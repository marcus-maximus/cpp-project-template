# cpp-project-template
This code is a template for new c++ projects.

Features:
- Build process with CMake
- Testing with catch2 and rapidcheck
- Manage 3rd party libraries with vcpkg
- CI with Azure DevOps

The c++ example code consists of a library and an executable linking the library. To build the project call ```bootstrap.ps1``` and then ```build.ps1```.

# CI status
[![Build Status](https://dev.azure.com/marcus-schaber/cpp_project_template/_apis/build/status/marcus-maximus.cpp-project-template?branchName=master)](https://dev.azure.com/marcus-schaber/cpp_project_template/_build/latest?definitionId=8&branchName=master)