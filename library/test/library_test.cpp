#define CATCH_CONFIG_MAIN  // This tells Catch to provide a main() - only do this in one cpp file
#include <catch.hpp>

#include <library.h>

TEST_CASE("One plus one", "[add]")
{
	REQUIRE(add(1, 1) == 2);
}

SCENARIO("Properties of add")
{
	GIVEN("Two positive values")
	{
		int a = 2;
		int b = 3;

		WHEN("they are added")
		{
			int sum = add(a, b);

			THEN("the sum is positive")
			{
				REQUIRE(sum >= 0);
			}
		}
	}
}