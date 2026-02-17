param(
    [Parameter(Mandatory)]
    [string]
    $CompileCommandsPath,

    [string[]]
    $Files = @()
)

$RepoRoot = "$PSScriptRoot/.."

if (Test-Path $CompileCommandsPath -PathType Container) {
        $CompileCommandsPath = Join-Path $CompileCommandsPath "compile_commands.json"
}
if (Test-Path $CompileCommandsPath -PathType Leaf) {
    if (!($Files)) {
        $CompileCommands = Get-Content $CompileCommandsPath | ConvertFrom-Json
        $Files = $CompileCommands | ForEach-Object { $_.file }
    }
} else {
    Write-Error "Could not find compile_commands.json at $CompileCommandsPath"
    exit 1
}

clang-tidy -p $CompileCommandsPath $Files
