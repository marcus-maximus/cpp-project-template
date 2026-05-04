#include <library.h>

#include <iostream>

int main()
{
    auto const a = 1;
    auto const b = 1;
    auto result = add(a, b);

    std::cout << a << " + " << b << " equals " << result << std::endl;

    return 0;
}
