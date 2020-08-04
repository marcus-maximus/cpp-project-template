add_executable(executable source/main.cpp)

target_compile_features(executable PUBLIC cxx_std_17)

target_link_libraries(executable PRIVATE library)