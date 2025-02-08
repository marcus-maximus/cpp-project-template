param(
    [Parameter(Mandatory)]
    [string]
    $BuildPath,

    [string[]]
    $Files = @()
)

$RepoRoot = "$PSScriptRoot/.."

if (!($Files)) {
    $CompileCommandsPath = Join-Path $BuildPath "compile_commands.json"
    if (Test-Path $CompileCommandsPath) {
        $CompileCommands = Get-Content $CompileCommandsPath | ConvertFrom-Json
        $Files = $CompileCommands | ForEach-Object { $_.file }
    } else {
        $Files = Get-ChildItem $RepoRoot -Recurse -Filter *.cpp,*.h
    }
}

clang-tidy -p $BuildPath $Files
