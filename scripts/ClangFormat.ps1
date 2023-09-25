param (
    [string]
    $Path = $PWD,

    [ValidateSet("Check", "EditInPlace", "ShowDiff")]
    [string]
    $Mode = "Check",

    [string[]]
    $FileExtensions = ("h", "hpp", "c", "cpp", "cppm", "ixx")
)

function CheckFormat($Files) {
    clang-format --dry-run -Werror $Files
}

function EditInPlace($Files) {
    clang-format -i $Files
}

function GetDiff($File) {
    $formatted = clang-format $File
    $formatted | git --no-pager diff --no-index --ignore-cr-at-eol -- $File -
}

function GetDiffs($Files) {
    $Files | ForEach-Object {
        $diff = GetDiff $_
        # Filter empty results and add an empty string
        # so that a newline gets added if printed or saved to a file
        if ($diff) { $diff + "" }
    }
}

$FileRegex = ".+\.($($FileExtensions -join '|'))$"
$Files = Get-ChildItem $Path -Recurse | Where-Object Name -match $FileRegex

switch ($Mode) {
    "Check" { CheckFormat $Files }
    "EditInPlace" { EditInPlace $Files }
    "ShowDiff" { GetDiffs $Files }
    Default {}
}
