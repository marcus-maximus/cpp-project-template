param(
    [String]
    $ImageName = "cpp-project-build",

    [String]
    [ValidateSet("Windows", "Linux")]
    $ContainerOS = $isWindows ? "Windows" : "Linux",

    [String]
    $HostSourceDirectory = "$PWD",

    [String]
    $HostBuildDirectory = "$PWD/build"
)


switch ($ContainerOS) {
    Windows {
        $ToolChainFile = "C:\cpp-project\vcpkg\scripts\buildsystems\vcpkg.cmake"
        $ProjectPath = "C:\cpp-project\cpp-project"
    }

    Linux {
        $ToolChainFile = "/home/build/vcpkg/scripts/buildsystems/vcpkg.cmake"
        $ProjectPath = "/home/build/cpp-project"
    }
}

function Invoke-Container($command) {
    docker run `
        --rm `
        -v ${HostSourceDirectory}:${ProjectPath} `
        -v ${HostBuildDirectory}:${ProjectPath}/build `
        $ImageName `
        $command
}

if (!(Test-Path -Path $HostBuildDirectory)) {
    New-Item $HostBuildDirectory -ItemType Directory
}

Invoke-Container "cd $ProjectPath && ./Build.ps1 -ToolChainFile $ToolChainFile"