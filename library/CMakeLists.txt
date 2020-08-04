add_library(library include/library.h source/library.cpp)

target_compile_features(library PUBLIC cxx_std_17)

target_include_directories(library PUBLIC include)

add_subdirectory(test)