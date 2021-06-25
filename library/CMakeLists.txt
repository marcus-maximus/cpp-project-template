add_library(library STATIC include/library.h source/library.cpp)

target_compile_features(library PUBLIC cxx_std_17)

target_include_directories(library PUBLIC include)
set_target_properties(library PROPERTIES PUBLIC_HEADER include/library.h)

install(TARGETS library 
    ARCHIVE
    PUBLIC_HEADER)

add_subdirectory(test)