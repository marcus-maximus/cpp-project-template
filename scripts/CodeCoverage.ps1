Param(
	[string]
	$BuildDir = "$PSScriptRoot/../out/build/code-coverage",

	[string]
	$TargetExecutable = "$BuildDir/executable/executable.exe"
)

$coverageDataDir = "$BuildDir/coverage_data"

$env:LLVM_PROFILE_FILE = "$coverageDataDir/coverage_pid%p.profraw"
cmake --preset code-coverage
cmake --build --preset code-coverage
ctest --preset code-coverage

$profRawFiles = Get-ChildItem -Path $coverageDataDir -Filter "coverage_pid*.profraw" | ForEach-Object { $_.FullName }
llvm-profdata merge -sparse $profRawFiles -o $coverageDataDir/coverage.profdata
Remove-Item -Path $profRawFiles

llvm-cov show $TargetExecutable -instr-profile="$coverageDataDir/coverage.profdata"
