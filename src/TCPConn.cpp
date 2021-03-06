#include <stdexcept>
#include <strings.h>
#include <unistd.h>
#include <cstring>
#include <algorithm>
#include <iostream>
#include <sstream>
#include "TCPConn.h"
#include "strfuncts.h"
#include <crypto++/secblock.h>
#include <crypto++/osrng.h>
#include <crypto++/filters.h>
#include <crypto++/rijndael.h>
#include <crypto++/gcm.h>
#include <crypto++/aes.h>
#include <random>

using namespace CryptoPP;

// Common defines for this TCPConn
const unsigned int iv_size = AES::BLOCKSIZE;
const unsigned int key_size = AES::DEFAULT_KEYLENGTH;
const unsigned int auth_size = 16;

/**********************************************************************************************
 * TCPConn (constructor) - creates the connector and initializes - creates the command strings
 *                         to wrap around network commands
 *
 *    Params: key - reference to the pre-loaded AES key
 *            verbosity - stdout verbosity - 3 = max
 *
 **********************************************************************************************/

TCPConn::TCPConn(LogMgr &server_log, CryptoPP::SecByteBlock &key, unsigned int verbosity):
                                    _data_ready(false),
                                    _aes_key(key),
                                    _verbosity(verbosity),
                                    _server_log(server_log)
{
   // prep some tools to search for command sequences in data
   uint8_t slash = (uint8_t) '/';
   c_rep.push_back((uint8_t) '<');
   c_rep.push_back((uint8_t) 'R');
   c_rep.push_back((uint8_t) 'E');
   c_rep.push_back((uint8_t) 'P');
   c_rep.push_back((uint8_t) '>');

   c_endrep = c_rep;
   c_endrep.insert(c_endrep.begin()+1, 1, slash);

   c_ack.push_back((uint8_t) '<');
   c_ack.push_back((uint8_t) 'A');
   c_ack.push_back((uint8_t) 'C');
   c_ack.push_back((uint8_t) 'K');
   c_ack.push_back((uint8_t) '>');

   c_auth.push_back((uint8_t) '<');
   c_auth.push_back((uint8_t) 'A');
   c_auth.push_back((uint8_t) 'U');
   c_auth.push_back((uint8_t) 'T');
   c_auth.push_back((uint8_t) '>');

   c_endauth = c_auth;
   c_endauth.insert(c_endauth.begin()+1, 1, slash);

    c_rand.push_back((uint8_t) '<');
    c_rand.push_back((uint8_t) 'R');
    c_rand.push_back((uint8_t) 'A');
    c_rand.push_back((uint8_t) 'N');
    c_rand.push_back((uint8_t) '>');

    c_endrand = c_rand;
    c_endrand.insert(c_endrand.begin()+1, 1, slash);

   c_sid.push_back((uint8_t) '<');
   c_sid.push_back((uint8_t) 'S');
   c_sid.push_back((uint8_t) 'I');
   c_sid.push_back((uint8_t) 'D');
   c_sid.push_back((uint8_t) '>');

   c_endsid = c_sid;
   c_endsid.insert(c_endsid.begin()+1, 1, slash);
}


TCPConn::~TCPConn() {

}

/**********************************************************************************************
 * accept - simply calls the acceptFD FileDesc method to accept a connection on a server socket.
 *
 *    Params: server - an open/bound server file descriptor with an available connection
 *
 *    Throws: socket_error for recoverable errors, runtime_error for unrecoverable types
 **********************************************************************************************/

bool TCPConn::accept(SocketFD &server) {
   // Accept the connection
   bool results = _connfd.acceptFD(server);


   // Set the state as waiting for the authorization packet
   _status = s_connected;
   _connected = true;
   return results;
}

/**********************************************************************************************
 * sendData - sends the data in the parameter to the socket
 *
 *    Params:  msg - the string to be sent
 *             size - if we know how much data we should expect to send, this should be populated
 *
 *    Throws: runtime_error for unrecoverable errors
 **********************************************************************************************/

bool TCPConn::sendData(std::vector<uint8_t> &buf) {
   
   _connfd.writeBytes<uint8_t>(buf);
   
   return true;
}

/**********************************************************************************************
 * sendEncryptedData - sends the data in the parameter to the socket after block encrypting it
 *
 *    Params:  msg - the string to be sent
 *             size - if we know how much data we should expect to send, this should be populated
 *
 *    Throws: runtime_error for unrecoverable errors
 **********************************************************************************************/

bool TCPConn::sendEncryptedData(std::vector<uint8_t> &buf) {

   // Encrypt
   encryptData(buf);

   // And send!
   return sendData(buf);
}

/**********************************************************************************************
 * encryptData - block encrypts data and places the results in the buffer in <ID><Data> format
 *
 *    Params:  buf - where to place the <IV><Data> stream
 *
 *    Throws: runtime_error for unrecoverable errors
 **********************************************************************************************/

void TCPConn::encryptData(std::vector<uint8_t> &buf) {
   // For the initialization vector
   SecByteBlock init_vector(iv_size);
   AutoSeededRandomPool rnd;

   // Generate our random init vector
   rnd.GenerateBlock(init_vector, init_vector.size());

   // Encrypt the data
   CFB_Mode<AES>::Encryption encryptor;
   encryptor.SetKeyWithIV(_aes_key, _aes_key.size(), init_vector);

   std::string cipher;
   ArraySource as(buf.data(), buf.size(), true,
            new StreamTransformationFilter(encryptor, new StringSink(cipher)));

   // Now add the IV to the stream we will be sending out
   std::vector<uint8_t> enc_data(init_vector.begin(), init_vector.end());
   enc_data.insert(enc_data.end(), cipher.begin(), cipher.end());
   buf = enc_data;
}

/**********************************************************************************************
 * handleConnection - performs a check of the connection, looking for data on the socket and
 *                    handling it based on the _status, or stage, of the connection
 *
 *    Throws: runtime_error for unrecoverable issues
 **********************************************************************************************/

void TCPConn::handleConnection() {

   try {
      switch (_status) {

         // Client: Just connected, send our SID
         case s_connecting:
            sendSID();
            break;

         // Server: Wait for the SID from a newly-connected client
         case s_connected:
            waitForSID();
            break;

            //client authentication part 1
          case s_clientauth1:
              authClient1();
              break;

              //server authentication part1
          case s_serverauth1:
              authServer1();
              break;

              //client authenication part 2
          case s_clientauth2:
              authClient2();
              break;

              // Client: connecting user - replicate data
         case s_datatx:
            transmitData();
            break;

         // Server: Receive data from the client
         case s_datarx:
            waitForData();
            break;
   
         // Client: Wait for acknowledgement that data sent was received before disconnecting
         case s_waitack:
            awaitAck();
            break;
         
         // Server: Data received and conn disconnected, but waiting for the data to be retrieved
         case s_hasdata:
            break;

         default:
            throw std::runtime_error("Invalid connection status!");
            break;
      }
   } catch (socket_error &e) {
      std::cout << "Socket error, disconnecting.\n";
      disconnect();
      return;
   }

}

/**********************************************************************************************
 * sendSID()  - Client: after a connection, client sends its Server ID to the server
 *
 *    Throws: socket_error for network issues, runtime_error for unrecoverable issues
 **********************************************************************************************/

void TCPConn::sendSID() {
   std::vector<uint8_t> buf(_svr_id.begin(), _svr_id.end());
   wrapCmd(buf, c_sid, c_endsid);
   sendData(buf);

   _status = s_clientauth1;
}

/**********************************************************************************************
 * waitForSID()  - receives the SID and sends our SID
 *
 *    Throws: socket_error for network issues, runtime_error for unrecoverable issues
 **********************************************************************************************/

void TCPConn::waitForSID() {

   // If data on the socket, should be our Auth string from our host server
   if (_connfd.hasData()) {
      std::vector<uint8_t> buf;
      getData(buf);
      if (buf.size() <= 0)
         return;

      if (!getCmdData(buf, c_sid, c_endsid)) {
         std::stringstream msg;
         msg << "SID string from connecting client invalid format. Cannot authenticate.";
         _server_log.writeLog(msg.str().c_str());
         disconnect();
         return;
      }

      std::string node(buf.begin(), buf.end());
      setNodeID(node.c_str());
      sendRandomAuth();
      /*
      // Send our Node ID
      buf.assign(_svr_id.begin(), _svr_id.end());
      wrapCmd(buf, c_sid, c_endsid);
      sendData(buf);
*/
      _status = s_serverauth1;
   }
}

/**********************************************************************************************
 * authClient1()  - receives the random string from server and sends it back encrypted
 *
 *    Throws: socket_error for network issues, runtime_error for unrecoverable issues
 **********************************************************************************************/

void TCPConn::authClient1(){
    if (_connfd.hasData()) {
        std::vector<uint8_t> buf;

        if (!getData(buf))
            return;

        if (!getCmdData(buf, c_rand, c_endrand)) {
            std::stringstream msg;
            msg << "Tried to receive random bytes. Failed. Node:" << getNodeID() << "\n";
            _server_log.writeLog(msg.str().c_str());
        }

        encryptData(buf);
        wrapCmd(buf, c_auth, c_endauth);
        sendData(buf);
        sendRandomAuth();

        _status = s_clientauth2;
    }
}

/**********************************************************************************************
 * authClient2()  - receives the encrypted string from the server checks if it is the string saved in
 * TCP conn in _authstr, and receives the SID from the server
 *
 *    Throws: socket_error for network issues, runtime_error for unrecoverable issues
 **********************************************************************************************/
void TCPConn::authClient2(){
    if (_connfd.hasData()) {
        std::vector<uint8_t> buf;

        if (!getData(buf))
            return;

        std::vector<uint8_t> newcmd = getMultipleCmdData(buf, c_auth, c_endauth);
        if (newcmd.size() == 0) {
            std::stringstream msg;
            msg << "Tried to receive encrypted bytes. Failed. Node:" << getNodeID() << "\n";
            _server_log.writeLog(msg.str().c_str());
        }

        //parse the data inbetween the tags perhaps.. have to do so encrypted and random numbers
        decryptData(newcmd); //make sure if the tags were still on
        std::string translatedData (newcmd.begin(), newcmd.end()); //not sure if i'm doing this right
        std::string str(_authstr.begin(), _authstr.end());

        if (translatedData.compare(str) != 0){ //check to make sure that the encrypted is the same as athe stored string
            std::stringstream msg;
            msg << "Bad encyrption from the server. Node:" << getNodeID() << "\n";
            _server_log.writeLog(msg.str().c_str());
            disconnect();
            return;
        }

        std::vector<uint8_t> newcmd2 = getMultipleCmdData(buf, c_sid, c_endsid);
        if (newcmd2.size() == 0) {
            std::stringstream msg;
            msg << "SID string from connected server invalid format. Cannot authenticate.";
            _server_log.writeLog(msg.str().c_str());
            disconnect();
            return;
        }

        std::string node(newcmd2.begin(), newcmd2.end());
        setNodeID(node.c_str());

        _status = s_datatx;
    }
}

/**********************************************************************************************
 * authServer1()  - receives  the encrypted string from teh client, checks it against _authstr
 * gets the random string from the client, encrypts it, and then sends it back. also sends its SID
 *
 *    Throws: socket_error for network issues, runtime_error for unrecoverable issues
 **********************************************************************************************/
void TCPConn::authServer1(){
    if (_connfd.hasData()) {
        std::vector<uint8_t> buf;

        if (!getData(buf))
            return;

        std::vector<uint8_t> newcmd = getMultipleCmdData(buf, c_auth, c_endauth);
        if (newcmd.size() == 0) {
            std::stringstream msg;
            msg << "Tried to receive encrypted bytes. Failed. Node:" << getNodeID() << "\n";
            _server_log.writeLog(msg.str().c_str());
        }

        decryptData(newcmd); //find out if the tags are still on
        std::string translatedData (newcmd.begin(), newcmd.end());
        std::string str(_authstr.begin(), _authstr.end());

        if (translatedData == str) {

            std::vector<uint8_t> newcmd2 = getMultipleCmdData(buf, c_rand, c_endrand);
            if (newcmd2.size() == 0) {
                std::stringstream msg;
                msg << "Tried to receive random bytes. Failed. Node:" << getNodeID() << "\n";
                _server_log.writeLog(msg.str().c_str());
            }

            encryptData(newcmd2);
            wrapCmd(newcmd2, c_auth, c_endauth);
            sendData(newcmd2);

            std::vector<uint8_t> svrid;
            //send SID of server
            svrid.assign(_svr_id.begin(), _svr_id.end());
            wrapCmd(svrid, c_sid, c_endsid);
            sendData(svrid);

            _status = s_datarx;
        }
    }
}

//sendRandomAuth(): sends random vector<uint_8> to client/server and stores it in _authstr
void TCPConn::sendRandomAuth(){
    createRandAuthStr();
    auto buf = std::vector<uint8_t>(auth_size);
    std::copy(_authstr.begin(), _authstr.end(), buf.begin());
    wrapCmd(buf, c_rand, c_endrand);
    sendData(buf);
}

//actually generates the random vector<unint_8>
void TCPConn::createRandAuthStr(){
    std::default_random_engine generator{std::random_device{}()};
    std::uniform_int_distribution<uint8_t > distribution(0, 225);
    for (int i = 0; i < auth_size; i++)
        _authstr.emplace_back(distribution(generator));
}


/**********************************************************************************************
 * transmitData()  - receives the SID from the server and transmits data
 *
 *    Throws: socket_error for network issues, runtime_error for unrecoverable issues
 **********************************************************************************************/

void TCPConn::transmitData() {

      // Send the replication data
      sendData(_outputbuf);

      if (_verbosity >= 3)
         std::cout << "Successfully authenticated connection with " << getNodeID() <<
                      " and sending replication data.\n";

      // Wait for their response
      _status = s_waitack;

}


/**********************************************************************************************
 * waitForData - receiving server, authentication complete, wait for replication datai
               Also sends a plaintext random auth string of our own
 *
 *    Throws: socket_error for network issues, runtime_error for unrecoverable issues
 **********************************************************************************************/

void TCPConn::waitForData() {

   // If data on the socket, should be replication data
   if (_connfd.hasData()) {
      std::vector<uint8_t> buf;

      if (!getData(buf))
         return;

      if (!getCmdData(buf, c_rep, c_endrep)) {
         std::stringstream msg;
         msg << "Replication data possibly corrupted from" << getNodeID() << "\n";
         _server_log.writeLog(msg.str().c_str());
         disconnect();
         return;
      }

      // Got the data, save it
      _inputbuf = buf;
      _data_ready = true;

      // Send the acknowledgement and disconnect
      sendData(c_ack);

      if (_verbosity >= 2)
         std::cout << "Successfully received replication data from " << getNodeID() << "\n";


      disconnect();
      _status = s_hasdata;
   }
}


/**********************************************************************************************
 * awaitAwk - waits for the awk that data was received and disconnects
 *
 *    Throws: socket_error for network issues, runtime_error for unrecoverable issues
 **********************************************************************************************/

void TCPConn::awaitAck() {

   // Should have the awk message
   if (_connfd.hasData()) {
      std::vector<uint8_t> buf;

      if (!getData(buf))
         return;

      if (findCmd(buf, c_ack) == buf.end())
      {
         std::stringstream msg;
         msg << "Awk expected from data send, received something else. Node:" << getNodeID() << "\n";
         _server_log.writeLog(msg.str().c_str());
      }
  
      if (_verbosity >= 3)
         std::cout << "Data ack received from " << getNodeID() << ". Disconnecting.\n";

 
      disconnect();
   }
}

/**********************************************************************************************
 * getData - Reads in data from the socket and checks to see if there's an end command to the
 *           message to confirm we got it all
 *
 *    Params: None - data is stored in _inputbuf for retrieval with GetInputData
 *
 *    Returns: true if the data is ready to be read, false if they lost connection
 *
 *    Throws: runtime_error for unrecoverable issues
 **********************************************************************************************/

bool TCPConn::getData(std::vector<uint8_t> &buf) {

   std::vector<uint8_t> readbuf;
   size_t count = 0;

   buf.clear();

   while (_connfd.hasData()) {
      // read the data on the socket up to 1024
      count += _connfd.readBytes<uint8_t>(readbuf, 1024);

      // check if we lost connection
      if (readbuf.size() == 0) {
         std::stringstream msg;
         std::string ip_addr;
         msg << "Connection from server " << _node_id << " lost (IP: " << 
                                                         getIPAddrStr(ip_addr) << ")"; 
         _server_log.writeLog(msg.str().c_str());
         disconnect();
         return false;
      }

      buf.insert(buf.end(), readbuf.begin(), readbuf.end());

      // concat the data onto anything we've read before
//      _inputbuf.insert(_inputbuf.end(), readbuf.begin(), readbuf.end());
   }
   return true;
}

/**********************************************************************************************
 * decryptData - Takes in an encrypted buffer in the form IV/Data and decrypts it, replacing
 *               buf with the decrypted info (destroys IV string>
 *
 *    Params: buf - the encrypted string and holds the decrypted data (minus IV)
 *
 **********************************************************************************************/
void TCPConn::decryptData(std::vector<uint8_t> &buf) {
   // For the initialization vector
   SecByteBlock init_vector(iv_size);

   // Copy the IV from the incoming stream of data
   init_vector.Assign(buf.data(), iv_size);
   buf.erase(buf.begin(), buf.begin() + iv_size);

   // Decrypt the data
   CFB_Mode<AES>::Decryption decryptor;
   decryptor.SetKeyWithIV(_aes_key, _aes_key.size(), init_vector);

   std::string recovered;
   ArraySource as(buf.data(), buf.size(), true,
            new StreamTransformationFilter(decryptor, new StringSink(recovered)));

   buf.assign(recovered.begin(), recovered.end());

}


/**********************************************************************************************
 * getEncryptedData - Reads in data from the socket and decrypts it, passing the decrypted
 *                    data back in buf
 *
 *    Params: None - data is stored in _inputbuf for retrieval with GetInputData
 *
 *    Returns: true if the data is ready to be read, false otherwise
 *
 *    Throws: runtime_error for unrecoverable issues
 **********************************************************************************************/

bool TCPConn::getEncryptedData(std::vector<uint8_t> &buf) {
   // Get the data from the socket
   if (!getData(buf))
      return false;

   decryptData(buf);

   return true; 
}

/**********************************************************************************************
 * findCmd - returns an iterator to the location of a string where a command starts
 * hasCmd - returns true if command was found, false otherwise
 *
 *    Params: buf = the data buffer to look for the command within
 *            cmd - the command string to search for in the data
 *
 *    Returns: iterator - points to cmd position if found, end() if not found
 *
 **********************************************************************************************/

std::vector<uint8_t>::iterator TCPConn::findCmd(std::vector<uint8_t> &buf, std::vector<uint8_t> &cmd) {
   return std::search(buf.begin(), buf.end(), cmd.begin(), cmd.end());
}

bool TCPConn::hasCmd(std::vector<uint8_t> &buf, std::vector<uint8_t> &cmd) {
   return !(findCmd(buf, cmd) == buf.end());
}

/**********************************************************************************************
 * getCmdData - looks for a startcmd and endcmd and returns the data between the two 
 *
 *    Params: buf = the string to search for the tags
 *            startcmd - the command at the beginning of the data sought
 *            endcmd - the command at the end of the data sought
 *
 *    Returns: true if both start and end commands were found, false otherwisei
 *
 **********************************************************************************************/

bool TCPConn::getCmdData(std::vector<uint8_t> &buf, std::vector<uint8_t> &startcmd, 
                                                    std::vector<uint8_t> &endcmd) {
   std::vector<uint8_t> temp = buf;
   auto start = findCmd(temp, startcmd);
   auto end = findCmd(temp, endcmd);

   if ((start == temp.end()) || (end == temp.end())  || (start == end))
      return false;

   buf.assign(start + startcmd.size(), end);
   return true;
}

std::vector<uint8_t> TCPConn::getMultipleCmdData(std::vector<uint8_t> buf, std::vector<uint8_t> &startcmd,
                                        std::vector<uint8_t> &endcmd) {
    std::vector<uint8_t> temp = buf;
    std::vector<uint8_t> cmd;
    auto start = findCmd(temp, startcmd);
    auto end = findCmd(temp, endcmd);

    if ((start == temp.end()) || (end == temp.end())  || (start == end))
        return cmd;

    cmd.assign(start + startcmd.size(), end);
    return cmd;

}

/**********************************************************************************************
 * wrapCmd - wraps the command brackets around the passed-in data
 *
 *    Params: buf = the string to wrap around
 *            startcmd - the command at the beginning of the data
 *            endcmd - the command at the end of the data
 *
 **********************************************************************************************/

void TCPConn::wrapCmd(std::vector<uint8_t> &buf, std::vector<uint8_t> &startcmd,
                                                    std::vector<uint8_t> &endcmd) {
   std::vector<uint8_t> temp = startcmd;
   temp.insert(temp.end(), buf.begin(), buf.end());
   temp.insert(temp.end(), endcmd.begin(), endcmd.end());

   buf = temp;
}


/**********************************************************************************************
 * getReplData - Returns the data received on the socket and marks the socket as done
 *
 *    Params: buf = the data received
 *
 *
 *    Throws: runtime_error for unrecoverable issues
 **********************************************************************************************/

void TCPConn::getInputData(std::vector<uint8_t> &buf) {

   // Returns the replication data off this connection, then prepares it to be removed
   buf = _inputbuf;

   _data_ready = false;
   _status = s_none;
}

/**********************************************************************************************
 * connect - Opens the socket FD, attempting to connect to the remote server
 *
 *    Params:  ip_addr - ip address string to connect to
 *             port - port in host format to connect to
 *
 *    Throws: socket_error exception if failed. socket_error is a child class of runtime_error
 **********************************************************************************************/

void TCPConn::connect(const char *ip_addr, unsigned short port) {

   // Set the status to connecting
   _status = s_connecting;

   // Try to connect
   if (!_connfd.connectTo(ip_addr, port))
      throw socket_error("TCP Connection failed!");

   _connected = true;
}

// Same as above, but ip_addr and port are in network (big endian) format
void TCPConn::connect(unsigned long ip_addr, unsigned short port) {
   // Set the status to connecting
   _status = s_connecting;

   if (!_connfd.connectTo(ip_addr, port))
      throw socket_error("TCP Connection failed!");

   _connected = true;
}

/**********************************************************************************************
 * assignOutgoingData - sets up the connection so that, at the next handleConnection, the data
 *                      is sent to the target server
 *
 *    Params:  data - the data stream to send to the server
 *
 **********************************************************************************************/

void TCPConn::assignOutgoingData(std::vector<uint8_t> &data) {

   _outputbuf.clear();
   _outputbuf = c_rep;
   _outputbuf.insert(_outputbuf.end(), data.begin(), data.end());
   _outputbuf.insert(_outputbuf.end(), c_endrep.begin(), c_endrep.end());
}
 

/**********************************************************************************************
 * disconnect - cleans up the socket as required and closes the FD
 *
 *    Throws: runtime_error for unrecoverable issues
 **********************************************************************************************/
void TCPConn::disconnect() {
   _connfd.closeFD();
   _connected = false;
}


/**********************************************************************************************
 * isConnected - performs a simple check on the socket to see if it is still open 
 *
 *    Throws: runtime_error for unrecoverable issues
 **********************************************************************************************/
bool TCPConn::isConnected() {
   return _connected;
   // return _connfd.isOpen(); // This does not work very well
}

/**********************************************************************************************
 * getIPAddrStr - gets a string format of the IP address and loads it in buf
 *
 **********************************************************************************************/
const char *TCPConn::getIPAddrStr(std::string &buf) {
   _connfd.getIPAddrStr(buf);
   return buf.c_str();
}

