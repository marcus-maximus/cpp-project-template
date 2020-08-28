git clone https://github.com/microsoft/vcpkg.git

if($isWindows) {
	./vcpkg/bootstrap-vcpkg.bat
	./vcpkg/vcpkg install catch2:x64-windows
} elseif($isLinux) {
	sh ./vcpkg/bootstrap-vcpkg.sh
	./vcpkg/vcpkg install catch2:x64-linux
}
