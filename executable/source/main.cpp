#include <library.h>

#include <iostream>

int main()
{
	auto const a = 1;
	auto const b = 1;
	auto result = add(1, 1);

	std::cout << a << " + " << b << " equals " << result << std::endl;

	return 0;
}