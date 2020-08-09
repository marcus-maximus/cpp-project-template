add_executable(library_test library_test.cpp)
add_test(library_test library_test)

find_package(Catch2 CONFIG REQUIRED)

target_link_libraries(library_test PRIVATE library)
target_link_libraries(library_test PRIVATE Catch2::Catch2)