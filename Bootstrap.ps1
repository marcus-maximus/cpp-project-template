param (
	[String]
	$VcpkgPath = "./vcpkg"
)

$setupVcpkg = !(Test-Path -Path $VcpkgPath)
$vcpkgURL = "https://github.com/microsoft/vcpkg.git"

if($isWindows) {
	if ($setupVcpkg) {
		git clone $vcpkgURL $VcpkgPath
		& $VcpkgPath/bootstrap-vcpkg.bat
	}
} elseif($isLinux) {
	if ($setupVcpkg) {
		git clone $vcpkgURL $VcpkgPath
		sh $VcpkgPath/bootstrap-vcpkg.sh
	}
}
