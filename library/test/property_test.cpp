#include <rapidcheck.h>

#include<library.h>

int main()
{
    rc::check("add is commutative",
        [](const int a, const int b) {
            RC_ASSERT(add(a, b) == add(b, a))
        })

    rc::check("add is associative",
        [](const int a, const int b, const int c) {
            RC_ASSERT(add(a, add(b, c)) == add(add(a, b), c))
        })

    return 0;
}