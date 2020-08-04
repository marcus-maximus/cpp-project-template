add_executable(library_test library_test.cpp)
add_test(library_test library_test)

target_link_libraries(library_test PRIVATE library)

target_compile_features(library_test PUBLIC cxx_std_17)