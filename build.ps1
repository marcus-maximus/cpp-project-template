New-Item build -ItemType Directory -ErrorAction Continue
cmake -S . -B build -D CMAKE_TOOLCHAIN_FILE=vcpkg/scripts/buildsystems/vcpkg.cmake
cmake --build build