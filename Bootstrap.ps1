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
	& $VcpkgPath/vcpkg install catch2:x64-windows
	& $VcpkgPath/vcpkg install rapidcheck:x64-windows
} elseif($isLinux) {
	if ($setupVcpkg) {
		git clone $vcpkgURL $VcpkgPath
		sh $VcpkgPath/bootstrap-vcpkg.sh
	}
	& $VcpkgPath/vcpkg install catch2:x64-linux
	& $VcpkgPath/vcpkg install rapidcheck:x64-linux
}
