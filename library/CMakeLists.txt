add_library(library STATIC)

target_sources(library
	PUBLIC FILE_SET HEADERS
		FILES
			include/library.h
		BASE_DIRS include
	PRIVATE
		source/library.cpp
)

target_compile_features(library PUBLIC cxx_std_20)
target_compile_options(library PRIVATE 
	$<$<CXX_COMPILER_ID:MSVC>:/W4 /WX>
	$<$<CXX_COMPILER_ID:GNU,Clang>:-Wall -Wextra -Werror>
)

install(TARGETS library
    ARCHIVE
    FILE_SET HEADERS DESTINATION include/library
)

add_subdirectory(test)