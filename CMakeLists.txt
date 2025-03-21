cmake_minimum_required(VERSION 3.30)

project(cpp_project)

# Optionally set c++ standard for all targets
#set(CMAKE_CXX_STANDARD 20)

enable_testing()

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_SOURCE_DIR}/install" CACHE PATH "..." FORCE)
endif()

add_subdirectory(library)
add_subdirectory(executable)