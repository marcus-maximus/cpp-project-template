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
	$AdditionalConfigureArguments = "-G", "Visual Studio 17 2022",  "-A", "x64"
    $AdditionalBuildArguments = "--config", "$BuildType"
} elseif($isLinux) {
    $AdditionalConfigureArguments = "-G", "Unix Makefiles"
    $AdditionalBuildArguments = ""
}


if (!(Test-Path -Path $BuildDirectory)) {
    New-Item $BuildDirectory -ItemType Directory
}

cmake -S $SourceDirectory -B $BuildDirectory -D CMAKE_BUILD_TYPE=$BuildType -D CMAKE_TOOLCHAIN_FILE=$ToolChainFile $AdditionalConfigureArguments
cmake --build $BuildDirectory $AdditionalBuildArguments