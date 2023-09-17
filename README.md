# cpp-project-template
This is a template for new c++ projects. It consists of a library and an executable linking the library.

Features:
- Build process with CMake
- Testing with catch2 and rapidcheck
- Manage 3rd party libraries with vcpkg
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
cmake --preset dev-debug && cmake --build --preset dev-debug
```
