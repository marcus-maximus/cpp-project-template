param(
    [ValidateSet("Windows", "Linux")]
    [String]
    $ContainerOS = $isWindows ? "Windows" : "Linux",

    [String]
    $HostSourceDirectory = "$PSScriptRoot/..",

    [String]
    $HostBuildDirectory = "$PSScriptRoot/../out",

    [Parameter(ParameterSetName="Interactive")]
    [switch]
    $Interactive,

    [Parameter(ParameterSetName="Command")]
    [String]
    $Command = ""
)

$ImageName = "cpp-project-build"
$Dockerfile = @{
    Windows = "$PSScriptRoot/windows.Dockerfile"; 
    Linux = "$PSScriptRoot/linux.Dockerfile"
}.$ContainerOS
$Workspace = @{
    Windows = "C:\workspace";
    Linux = "/home/build/workspace"
}.$ContainerOS
$ContainerSourceDirectory = "$Workspace/source"
$ContainerBuildDirectory = "$Workspace/build"

if ($isLinux) {
    $BuildArguments = "--build-arg", "USER_ID=$(id -u)", "--build-arg", "GROUP_ID=$(id -g)"
}
docker build -t $ImageName -f $Dockerfile $BuildArguments $PSScriptRoot/..

if (!(Test-Path -Path $HostBuildDirectory)) {
    New-Item $HostBuildDirectory -ItemType Directory
}

docker run `
    --rm `
    $(if ($Interactive) { "-it" }) `
    -v ${HostSourceDirectory}:${ContainerSourceDirectory} `
    -v ${HostBuildDirectory}:${ContainerBuildDirectory} `
    $ImageName `
    $(if (!$Interactive) { $Command })
