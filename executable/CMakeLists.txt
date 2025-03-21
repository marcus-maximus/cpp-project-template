add_executable(executable)

target_sources(executable
	PRIVATE 
		source/main.cpp
)

target_compile_features(executable PUBLIC cxx_std_20)
target_compile_options(executable PRIVATE 
	$<$<CXX_COMPILER_ID:MSVC>:/W4 /WX>
	$<$<CXX_COMPILER_ID:GNU,Clang>:-Wall -Wextra -Werror>
)

target_link_libraries(executable PRIVATE library)

install(TARGETS executable RUNTIME)