Param(
    [string]
    $BuildDir = "$PSScriptRoot/../out/build/code-coverage",

    [string]
    $TargetBinary = "$BuildDir/executable/executable.exe",

    [switch]
    $ShowSummary,

    [switch]
    $GenerateHtmlReport
)

$coverageDataDir = "$BuildDir/coverage_data"

if (Test-Path -Path $coverageDataDir) {
    Remove-Item -Recurse $coverageDataDir/*
}

$env:LLVM_PROFILE_FILE = "$coverageDataDir/coverage_pid%p.profraw"
cmake --preset code-coverage
cmake --build --preset code-coverage
ctest --preset code-coverage

$profRawFiles = Get-ChildItem -Path $coverageDataDir -Filter "coverage_pid*.profraw" | ForEach-Object { $_.FullName }
llvm-profdata merge -sparse $profRawFiles -o $coverageDataDir/coverage.profdata
Remove-Item -Path $profRawFiles

if ($ShowSummary) {
    llvm-cov report $TargetBinary -instr-profile="$coverageDataDir/coverage.profdata"
}
if ($GenerateHtmlReport) {
    llvm-cov show $TargetBinary -instr-profile="$coverageDataDir/coverage.profdata" -format="html" -output-dir="$coverageDataDir/html"
}
