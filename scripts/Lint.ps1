param (
    [string]
    $Path = $PWD,

    [ValidateSet("Check", "EditInPlace", "ShowDiff")]
    [string]
    $Mode = "Check",

    [string[]]
    $FileExtensions = ("h", "hpp", "c", "cpp", "cppm", "ixx")
)

function GetDiff($File) {
    $formatted = clang-format $File
    $formatted | git --no-pager diff --no-index -- $File -
}

$FileRegex = ".+\.($($FileExtensions -join '|'))$"
$Files = Get-ChildItem $Path -Recurse | Where-Object Name -match $FileRegex

switch ($Mode) {
    "EditInPlace" { clang-format -i $Files }
    "Check" { clang-format --dry-run -Werror $Files }
    "ShowDiff" { $Files | ForEach-Object { GetDiff $_ && Write-Output "" } }
    Default {}
}
