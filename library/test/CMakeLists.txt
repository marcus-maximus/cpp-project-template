add_executable(library_test library_test.cpp)
add_test(library_test library_test)

add_executable(property_test property_test.cpp)
add_test(property_test property_test)

find_package(Catch2 CONFIG REQUIRED)
find_package(rapidcheck CONFIG REQUIRED)

target_link_libraries(library_test PRIVATE library)
target_link_libraries(library_test PRIVATE Catch2::Catch2)

target_link_libraries(property_test PRIVATE library)
target_link_libraries(property_test PRIVATE rapidcheck rapidcheck_boost rapidcheck_catch rapidcheck_gmock)