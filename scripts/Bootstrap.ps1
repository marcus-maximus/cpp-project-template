param (
	[String]
	$VcpkgPath = "PSScriptPath/../vcpkg"
)

$vcpkgURL = "https://github.com/microsoft/vcpkg.git"

if (!(Test-Path -Path $VcpkgPath)) {
	git clone $vcpkgURL $VcpkgPath
	if($isWindows) {
		& $VcpkgPath/bootstrap-vcpkg.bat
	} elseif($isLinux) {
		sh $VcpkgPath/bootstrap-vcpkg.sh
	}
}
$env:VCPKG_ROOT = $VcpkgPath