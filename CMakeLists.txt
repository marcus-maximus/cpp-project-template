cmake_minimum_required(VERSION 3.15)

project(cmake_template)

# Optionally set c++ standard for all targets
#set(CMAKE_CXX_STANDARD 17)

enable_testing()

add_subdirectory(library)
add_subdirectory(executable)