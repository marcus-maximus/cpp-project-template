param (
	[String]
	$VcpkgPath = "PSScriptPath/../vcpkg"
)

$setupVcpkg = !(Test-Path -Path $VcpkgPath)
$vcpkgURL = "https://github.com/microsoft/vcpkg.git"

if ($setupVcpkg) {
	git clone $vcpkgURL $VcpkgPath
	if($isWindows) {
		& $VcpkgPath/bootstrap-vcpkg.bat
	} elseif($isLinux) {
		sh $VcpkgPath/bootstrap-vcpkg.sh
	}
}
