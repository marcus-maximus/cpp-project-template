add_executable(library_test library_test.cpp)
add_test(library_test library_test)

add_executable(property_test property_test.cpp)
add_test(property_test property_test)

find_package(Catch2 CONFIG REQUIRED)
find_package(rapidcheck CONFIG REQUIRED)

target_link_libraries(library_test PRIVATE library Catch2::Catch2WithMain)

target_link_libraries(property_test PRIVATE 
	library 
	Catch2::Catch2WithMain 
	rapidcheck rapidcheck_boost rapidcheck_catch rapidcheck_gmock
)
