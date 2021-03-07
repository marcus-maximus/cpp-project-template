param(
    [String]
    $SourceDirectory = ".",

    [String]
    $BuildDirectory = "build",

    [String]
    [ValidateSet("Release", "Debug")]
    $BuildType = "Release",

    [String]
    $ToolChainFile = "vcpkg/scripts/buildsystems/vcpkg.cmake"
)


if($isWindows) {
	$AdditionalConfigureArguments = "-G", "Visual Studio 16 2019",  "-A", "x64"
    $AdditionalBuildArguments = "--config", "$BuildType"
} elseif($isLinux) {
    $CMakeConfigureAruments = "-G", "Unix Makefiles"
    $AdditionalBuildArguments = ""
}

New-Item $BuildDirectory -ItemType Directory -ErrorAction Continue
cmake -S $SourceDirectory -B $BuildDirectory -D CMAKE_BUILD_TYPE=$BuildType -D CMAKE_TOOLCHAIN_FILE=$ToolChainFile $AdditionalConfigureArguments
cmake --build $BuildDirectory $AdditionalBuildArguments