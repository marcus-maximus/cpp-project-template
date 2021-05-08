param(
    [String]
    $ImageName = "cpp-project-build",

    [String]
    $Dockerfile = $IsWindows ? "Dockerfile_windows" : "Dockerfile_linux"
)

if($isLinux) {
    $AdditionalArguments = "--build-arg", "USER_ID=$(id -u)", "--build-arg", "GROUP_ID=$(id -g)"
}

docker build -t $ImageName -f $Dockerfile $AdditionalArguments .