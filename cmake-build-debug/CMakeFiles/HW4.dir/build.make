# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.15

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/claire/Downloads/clion-2019.3.2/bin/cmake/linux/bin/cmake

# The command to remove a file.
RM = /home/claire/Downloads/clion-2019.3.2/bin/cmake/linux/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/claire/AFIT-CSCE689-HW4-S

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/claire/AFIT-CSCE689-HW4-S/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/HW4.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/HW4.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/HW4.dir/flags.make

CMakeFiles/HW4.dir/src/repsvr_main.cpp.o: CMakeFiles/HW4.dir/flags.make
CMakeFiles/HW4.dir/src/repsvr_main.cpp.o: ../src/repsvr_main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/claire/AFIT-CSCE689-HW4-S/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/HW4.dir/src/repsvr_main.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/HW4.dir/src/repsvr_main.cpp.o -c /home/claire/AFIT-CSCE689-HW4-S/src/repsvr_main.cpp

CMakeFiles/HW4.dir/src/repsvr_main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW4.dir/src/repsvr_main.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/claire/AFIT-CSCE689-HW4-S/src/repsvr_main.cpp > CMakeFiles/HW4.dir/src/repsvr_main.cpp.i

CMakeFiles/HW4.dir/src/repsvr_main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW4.dir/src/repsvr_main.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/claire/AFIT-CSCE689-HW4-S/src/repsvr_main.cpp -o CMakeFiles/HW4.dir/src/repsvr_main.cpp.s

CMakeFiles/HW4.dir/src/ALMgr.cpp.o: CMakeFiles/HW4.dir/flags.make
CMakeFiles/HW4.dir/src/ALMgr.cpp.o: ../src/ALMgr.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/claire/AFIT-CSCE689-HW4-S/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/HW4.dir/src/ALMgr.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/HW4.dir/src/ALMgr.cpp.o -c /home/claire/AFIT-CSCE689-HW4-S/src/ALMgr.cpp

CMakeFiles/HW4.dir/src/ALMgr.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW4.dir/src/ALMgr.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/claire/AFIT-CSCE689-HW4-S/src/ALMgr.cpp > CMakeFiles/HW4.dir/src/ALMgr.cpp.i

CMakeFiles/HW4.dir/src/ALMgr.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW4.dir/src/ALMgr.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/claire/AFIT-CSCE689-HW4-S/src/ALMgr.cpp -o CMakeFiles/HW4.dir/src/ALMgr.cpp.s

CMakeFiles/HW4.dir/src/LogMgr.cpp.o: CMakeFiles/HW4.dir/flags.make
CMakeFiles/HW4.dir/src/LogMgr.cpp.o: ../src/LogMgr.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/claire/AFIT-CSCE689-HW4-S/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/HW4.dir/src/LogMgr.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/HW4.dir/src/LogMgr.cpp.o -c /home/claire/AFIT-CSCE689-HW4-S/src/LogMgr.cpp

CMakeFiles/HW4.dir/src/LogMgr.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW4.dir/src/LogMgr.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/claire/AFIT-CSCE689-HW4-S/src/LogMgr.cpp > CMakeFiles/HW4.dir/src/LogMgr.cpp.i

CMakeFiles/HW4.dir/src/LogMgr.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW4.dir/src/LogMgr.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/claire/AFIT-CSCE689-HW4-S/src/LogMgr.cpp -o CMakeFiles/HW4.dir/src/LogMgr.cpp.s

CMakeFiles/HW4.dir/src/TCPConn.cpp.o: CMakeFiles/HW4.dir/flags.make
CMakeFiles/HW4.dir/src/TCPConn.cpp.o: ../src/TCPConn.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/claire/AFIT-CSCE689-HW4-S/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object CMakeFiles/HW4.dir/src/TCPConn.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/HW4.dir/src/TCPConn.cpp.o -c /home/claire/AFIT-CSCE689-HW4-S/src/TCPConn.cpp

CMakeFiles/HW4.dir/src/TCPConn.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW4.dir/src/TCPConn.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/claire/AFIT-CSCE689-HW4-S/src/TCPConn.cpp > CMakeFiles/HW4.dir/src/TCPConn.cpp.i

CMakeFiles/HW4.dir/src/TCPConn.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW4.dir/src/TCPConn.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/claire/AFIT-CSCE689-HW4-S/src/TCPConn.cpp -o CMakeFiles/HW4.dir/src/TCPConn.cpp.s

CMakeFiles/HW4.dir/src/DronePlotDB.cpp.o: CMakeFiles/HW4.dir/flags.make
CMakeFiles/HW4.dir/src/DronePlotDB.cpp.o: ../src/DronePlotDB.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/claire/AFIT-CSCE689-HW4-S/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building CXX object CMakeFiles/HW4.dir/src/DronePlotDB.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/HW4.dir/src/DronePlotDB.cpp.o -c /home/claire/AFIT-CSCE689-HW4-S/src/DronePlotDB.cpp

CMakeFiles/HW4.dir/src/DronePlotDB.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW4.dir/src/DronePlotDB.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/claire/AFIT-CSCE689-HW4-S/src/DronePlotDB.cpp > CMakeFiles/HW4.dir/src/DronePlotDB.cpp.i

CMakeFiles/HW4.dir/src/DronePlotDB.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW4.dir/src/DronePlotDB.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/claire/AFIT-CSCE689-HW4-S/src/DronePlotDB.cpp -o CMakeFiles/HW4.dir/src/DronePlotDB.cpp.s

CMakeFiles/HW4.dir/src/FileDesc.cpp.o: CMakeFiles/HW4.dir/flags.make
CMakeFiles/HW4.dir/src/FileDesc.cpp.o: ../src/FileDesc.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/claire/AFIT-CSCE689-HW4-S/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building CXX object CMakeFiles/HW4.dir/src/FileDesc.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/HW4.dir/src/FileDesc.cpp.o -c /home/claire/AFIT-CSCE689-HW4-S/src/FileDesc.cpp

CMakeFiles/HW4.dir/src/FileDesc.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW4.dir/src/FileDesc.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/claire/AFIT-CSCE689-HW4-S/src/FileDesc.cpp > CMakeFiles/HW4.dir/src/FileDesc.cpp.i

CMakeFiles/HW4.dir/src/FileDesc.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW4.dir/src/FileDesc.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/claire/AFIT-CSCE689-HW4-S/src/FileDesc.cpp -o CMakeFiles/HW4.dir/src/FileDesc.cpp.s

CMakeFiles/HW4.dir/src/Server.cpp.o: CMakeFiles/HW4.dir/flags.make
CMakeFiles/HW4.dir/src/Server.cpp.o: ../src/Server.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/claire/AFIT-CSCE689-HW4-S/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building CXX object CMakeFiles/HW4.dir/src/Server.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/HW4.dir/src/Server.cpp.o -c /home/claire/AFIT-CSCE689-HW4-S/src/Server.cpp

CMakeFiles/HW4.dir/src/Server.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW4.dir/src/Server.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/claire/AFIT-CSCE689-HW4-S/src/Server.cpp > CMakeFiles/HW4.dir/src/Server.cpp.i

CMakeFiles/HW4.dir/src/Server.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW4.dir/src/Server.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/claire/AFIT-CSCE689-HW4-S/src/Server.cpp -o CMakeFiles/HW4.dir/src/Server.cpp.s

CMakeFiles/HW4.dir/src/QueueMgr.cpp.o: CMakeFiles/HW4.dir/flags.make
CMakeFiles/HW4.dir/src/QueueMgr.cpp.o: ../src/QueueMgr.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/claire/AFIT-CSCE689-HW4-S/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Building CXX object CMakeFiles/HW4.dir/src/QueueMgr.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/HW4.dir/src/QueueMgr.cpp.o -c /home/claire/AFIT-CSCE689-HW4-S/src/QueueMgr.cpp

CMakeFiles/HW4.dir/src/QueueMgr.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW4.dir/src/QueueMgr.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/claire/AFIT-CSCE689-HW4-S/src/QueueMgr.cpp > CMakeFiles/HW4.dir/src/QueueMgr.cpp.i

CMakeFiles/HW4.dir/src/QueueMgr.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW4.dir/src/QueueMgr.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/claire/AFIT-CSCE689-HW4-S/src/QueueMgr.cpp -o CMakeFiles/HW4.dir/src/QueueMgr.cpp.s

CMakeFiles/HW4.dir/src/TCPServer.cpp.o: CMakeFiles/HW4.dir/flags.make
CMakeFiles/HW4.dir/src/TCPServer.cpp.o: ../src/TCPServer.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/claire/AFIT-CSCE689-HW4-S/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_9) "Building CXX object CMakeFiles/HW4.dir/src/TCPServer.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/HW4.dir/src/TCPServer.cpp.o -c /home/claire/AFIT-CSCE689-HW4-S/src/TCPServer.cpp

CMakeFiles/HW4.dir/src/TCPServer.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW4.dir/src/TCPServer.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/claire/AFIT-CSCE689-HW4-S/src/TCPServer.cpp > CMakeFiles/HW4.dir/src/TCPServer.cpp.i

CMakeFiles/HW4.dir/src/TCPServer.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW4.dir/src/TCPServer.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/claire/AFIT-CSCE689-HW4-S/src/TCPServer.cpp -o CMakeFiles/HW4.dir/src/TCPServer.cpp.s

CMakeFiles/HW4.dir/src/ReplServer.cpp.o: CMakeFiles/HW4.dir/flags.make
CMakeFiles/HW4.dir/src/ReplServer.cpp.o: ../src/ReplServer.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/claire/AFIT-CSCE689-HW4-S/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_10) "Building CXX object CMakeFiles/HW4.dir/src/ReplServer.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/HW4.dir/src/ReplServer.cpp.o -c /home/claire/AFIT-CSCE689-HW4-S/src/ReplServer.cpp

CMakeFiles/HW4.dir/src/ReplServer.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW4.dir/src/ReplServer.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/claire/AFIT-CSCE689-HW4-S/src/ReplServer.cpp > CMakeFiles/HW4.dir/src/ReplServer.cpp.i

CMakeFiles/HW4.dir/src/ReplServer.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW4.dir/src/ReplServer.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/claire/AFIT-CSCE689-HW4-S/src/ReplServer.cpp -o CMakeFiles/HW4.dir/src/ReplServer.cpp.s

CMakeFiles/HW4.dir/src/AntennaSim.cpp.o: CMakeFiles/HW4.dir/flags.make
CMakeFiles/HW4.dir/src/AntennaSim.cpp.o: ../src/AntennaSim.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/claire/AFIT-CSCE689-HW4-S/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_11) "Building CXX object CMakeFiles/HW4.dir/src/AntennaSim.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/HW4.dir/src/AntennaSim.cpp.o -c /home/claire/AFIT-CSCE689-HW4-S/src/AntennaSim.cpp

CMakeFiles/HW4.dir/src/AntennaSim.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW4.dir/src/AntennaSim.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/claire/AFIT-CSCE689-HW4-S/src/AntennaSim.cpp > CMakeFiles/HW4.dir/src/AntennaSim.cpp.i

CMakeFiles/HW4.dir/src/AntennaSim.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW4.dir/src/AntennaSim.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/claire/AFIT-CSCE689-HW4-S/src/AntennaSim.cpp -o CMakeFiles/HW4.dir/src/AntennaSim.cpp.s

CMakeFiles/HW4.dir/src/strfuncts.cpp.o: CMakeFiles/HW4.dir/flags.make
CMakeFiles/HW4.dir/src/strfuncts.cpp.o: ../src/strfuncts.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/claire/AFIT-CSCE689-HW4-S/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_12) "Building CXX object CMakeFiles/HW4.dir/src/strfuncts.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/HW4.dir/src/strfuncts.cpp.o -c /home/claire/AFIT-CSCE689-HW4-S/src/strfuncts.cpp

CMakeFiles/HW4.dir/src/strfuncts.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/HW4.dir/src/strfuncts.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/claire/AFIT-CSCE689-HW4-S/src/strfuncts.cpp > CMakeFiles/HW4.dir/src/strfuncts.cpp.i

CMakeFiles/HW4.dir/src/strfuncts.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/HW4.dir/src/strfuncts.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/claire/AFIT-CSCE689-HW4-S/src/strfuncts.cpp -o CMakeFiles/HW4.dir/src/strfuncts.cpp.s

# Object files for target HW4
HW4_OBJECTS = \
"CMakeFiles/HW4.dir/src/repsvr_main.cpp.o" \
"CMakeFiles/HW4.dir/src/ALMgr.cpp.o" \
"CMakeFiles/HW4.dir/src/LogMgr.cpp.o" \
"CMakeFiles/HW4.dir/src/TCPConn.cpp.o" \
"CMakeFiles/HW4.dir/src/DronePlotDB.cpp.o" \
"CMakeFiles/HW4.dir/src/FileDesc.cpp.o" \
"CMakeFiles/HW4.dir/src/Server.cpp.o" \
"CMakeFiles/HW4.dir/src/QueueMgr.cpp.o" \
"CMakeFiles/HW4.dir/src/TCPServer.cpp.o" \
"CMakeFiles/HW4.dir/src/ReplServer.cpp.o" \
"CMakeFiles/HW4.dir/src/AntennaSim.cpp.o" \
"CMakeFiles/HW4.dir/src/strfuncts.cpp.o"

# External object files for target HW4
HW4_EXTERNAL_OBJECTS =

HW4: CMakeFiles/HW4.dir/src/repsvr_main.cpp.o
HW4: CMakeFiles/HW4.dir/src/ALMgr.cpp.o
HW4: CMakeFiles/HW4.dir/src/LogMgr.cpp.o
HW4: CMakeFiles/HW4.dir/src/TCPConn.cpp.o
HW4: CMakeFiles/HW4.dir/src/DronePlotDB.cpp.o
HW4: CMakeFiles/HW4.dir/src/FileDesc.cpp.o
HW4: CMakeFiles/HW4.dir/src/Server.cpp.o
HW4: CMakeFiles/HW4.dir/src/QueueMgr.cpp.o
HW4: CMakeFiles/HW4.dir/src/TCPServer.cpp.o
HW4: CMakeFiles/HW4.dir/src/ReplServer.cpp.o
HW4: CMakeFiles/HW4.dir/src/AntennaSim.cpp.o
HW4: CMakeFiles/HW4.dir/src/strfuncts.cpp.o
HW4: CMakeFiles/HW4.dir/build.make
HW4: CMakeFiles/HW4.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/claire/AFIT-CSCE689-HW4-S/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_13) "Linking CXX executable HW4"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/HW4.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/HW4.dir/build: HW4

.PHONY : CMakeFiles/HW4.dir/build

CMakeFiles/HW4.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/HW4.dir/cmake_clean.cmake
.PHONY : CMakeFiles/HW4.dir/clean

CMakeFiles/HW4.dir/depend:
	cd /home/claire/AFIT-CSCE689-HW4-S/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/claire/AFIT-CSCE689-HW4-S /home/claire/AFIT-CSCE689-HW4-S /home/claire/AFIT-CSCE689-HW4-S/cmake-build-debug /home/claire/AFIT-CSCE689-HW4-S/cmake-build-debug /home/claire/AFIT-CSCE689-HW4-S/cmake-build-debug/CMakeFiles/HW4.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/HW4.dir/depend

