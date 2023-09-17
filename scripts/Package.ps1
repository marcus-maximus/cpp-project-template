param(
    [String]
    $PackageDirectory = "$PSScriptRoot/out/install",

    [String]
    $PackageName = "cpp-project",

    [String]
    $BuildDirectory = "$PSScriptRoot/out/build",

    [String]
    [ValidateSet("Release", "Debug")]
    $BuildType = "Release"
)

cmake --install $BuildDirectory --config $BuildType --prefix $PackageDirectory
Compress-Archive -Path $PackageDirectory/* -DestinationPath "${PackageName}.zip" -Force