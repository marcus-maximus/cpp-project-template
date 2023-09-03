#include <rapidcheck.h>
#include <catch2/catch_test_macros.hpp>
#include <library.h>

TEST_CASE("add property check", "[add]")
{
    bool commutative = rc::check("add is commutative",
        [](const int a, const int b) {
            RC_ASSERT(add(a, b) == add(b, a));
        });
    REQUIRE(commutative);

    bool associative = rc::check("add is associative",
        [](const int a, const int b, const int c) {
            RC_ASSERT(add(a, add(b, c)) == add(add(a, b), c));
        });
    REQUIRE(associative);
}