param(
    [String]
    $ImageName = "cpp-project-build",

    [String]
    $Dockerfile = $IsWindows ? "Dockerfile_windows" : "Dockerfile_linux"
)

docker build -t $ImageName -f $Dockerfile .