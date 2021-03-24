param(
    [String]
    $ImageName = "cpp-project-build",

    [String]
    [ValidateSet("Windows", "Linux")]
    $ContainerOS = $isWindows ? "Windows" : "Linux",

    [String]
    $HostProjectPath = $PWD
)


switch ($ContainerOS) {
    Windows {
        $ToolChainFile = "C:\Users\ContainerUser\vcpkg\scripts\buildsystems\vcpkg.cmake"
        $ProjectPath = "C:\Users\ContainerUser\cpp-project"
    }

    Linux {
        $ToolChainFile = "/home/build/vcpkg/scripts/buildsystems/vcpkg.cmake"
        $ProjectPath = "/home/build/cpp-project"
    }
}

function Invoke-Container($command) {
    docker run `
        --rm `
        -v ${HostProjectPath}:${ProjectPath} `
        $ImageName `
        $command
}

Invoke-Container "cd $ProjectPath && ./Build.ps1 -ToolChainFile $ToolChainFile"