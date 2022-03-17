param(
    [String]
    $PackageDirectory = "install",

    [String]
    $PackageName = "cpp-project",

    [String]
    $BuildDirectory = "build",

    [String]
    [ValidateSet("Release", "Debug")]
    $BuildType = "Release"
)

cmake --install $BuildDirectory --config $BuildType --prefix $PackageDirectory
Compress-Archive -Path $PackageDirectory/* -DestinationPath "${PackageName}.zip" -Force