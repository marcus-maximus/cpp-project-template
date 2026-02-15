# cpp-project-template
This is a template for new c++ projects. It consists of a library and an executable linking the library.

Features:
- Builds with CMake
- Tests with catch2 and rapidcheck
- Manages 3rd party libraries with vcpkg
- CI with GitHub Actions

## Build
Build using cmake:
```
./scrips/Boostrap.ps1
cmake -S . -B ./out/build -D CMAKE_TOOLCHAIN_FILE="./vcpkg/scripts/buildsystems/vcpkg.cmake"
cmake --build ./out/build
```
Build using cmake presets:
```
./scripts/Bootstrap.ps1
cmake --preset debug && cmake --build --preset debug
```
An existing vcpkg installation can be used by setting the `VCPKG_ROOT` environment variable ([vcpkg documentation](https://learn.microsoft.com/en-us/vcpkg/get_started/get-started?pivots=shell-powershell#2---set-up-the-project)).
