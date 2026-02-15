# cpp-project-template
This is a template for new c++ projects. It consists of a library and an executable linking the library.

Features:
- Builds with CMake
- Tests with catch2 and rapidcheck
- Manages 3rd party libraries with vcpkg
- CI with GitHub Actions
- Docker images for consistent build environments
- ClangFormat and ClangTidy for code formatting and linting

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

## Scripts
The `scripts/` directory contains helper scripts used for common tasks during development and CI.

- **`Bootstrap.ps1`**  
  Clones and bootstraps `vcpkg` if it's not present, and sets `VCPKG_ROOT`. Example:
  ```powershell
  ./scripts/Bootstrap.ps1
  ```

- **`ClangFormat.ps1`**  
  Runs `clang-format` in various modes: check formatting, edit files in place, or show diffs. Example:
  ```powershell
  ./scripts/ClangFormat.ps1 -Path .\library\ -Mode Check
  ```

- **`ClangTidy.ps1`**  
  Runs `clang-tidy` against the build's `compile_commands.json` or a list of files. Example:
  ```powershell
  ./scripts/ClangTidy.ps1 -BuildPath ./out/build/release/ -Files "src/file1.cpp,src/file2.cpp"
  ```
  or to use the compile commands in Build directory:
  ```powershell
  ./scripts/ClangTidy.ps1 -BuildPath ./out/build/release/
  ```

- **`Package.ps1`**  
  Installs the built files into a packaging directory and creates a ZIP archive. Typical usage:
  ```powershell
  ./scripts/Package.ps1 -BuildType Release
  ```

- **`RunContainer.ps1`**  
  Builds and runs a Docker container for consistent build environments. Supports interactive shells or running a command inside the container. Example:
  ```powershell
  ./scripts/RunContainer.ps1 -Interactive
  ```
  or to run a specific command:
  ```powershell
  ./scripts/RunContainer.ps1 -Command "cmake --version"
  ```

Inspect the individual files for detailed behavior and available parameters.