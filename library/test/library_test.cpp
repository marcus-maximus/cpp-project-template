#define CATCH_CONFIG_MAIN  // This tells Catch to provide a main() - only do this in one cpp file
#include "catch.hpp"

#include <library.h>

TEST_CASE( "One plus one", "[add]" )
{
	REQUIRE(add(1, 1) == 2);
}