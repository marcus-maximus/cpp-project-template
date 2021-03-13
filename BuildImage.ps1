param(
    [String]
    $ImageName = "cpp-project-build",

    [String]
    $Dockerfile = $isWindows ? "Dockerfile_windows" : "Dockerfile_linux"
)

docker build -t $ImageName -f $Dockerfile .