param(
    [String]
    $SourceDirectory = ".",

    [String]
    $BuildDirectory = "build",

    [String]
    $ToolChainFile = "vcpkg/scripts/buildsystems/vcpkg.cmake"
)

New-Item $BuildDirectory -ItemType Directory -ErrorAction Continue
cmake -S $SourceDirectory -B $BuildDirectory -D CMAKE_TOOLCHAIN_FILE=$ToolChainFile
cmake --build $BuildDirectory