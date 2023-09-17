FROM mcr.microsoft.com/windows/servercore:ltsc2022

RUN powershell -Command Set-ExecutionPolicy Bypass -Scope Process -Force; \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

RUN choco install -y pwsh && \
    choco install -y git --params "/GitOnlyOnPath /NoGitLfs /NoShellIntegration" && \
    choco install -y cmake --installargs "ADD_CMAKE_TO_PATH=System" && \
    choco install -y ninja

ADD https://aka.ms/vs/17/release/vs_buildtools.exe C:\\TEMP\\vs_buildtools.exe
RUN C:\\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache \
    --installPath "C:\\BuildTools" \
    --add "Microsoft.VisualStudio.Workload.VCTools;includeRecommended"

WORKDIR C:\\workspace

SHELL ["pwsh", "-NoLogo", "-NoProfile", "-NonInteractive", "-Command"]

COPY .\\scripts\\Bootstrap.ps1 .
RUN .\\Bootstrap.ps1 -VcpkgPath C:\\workspace\\vcpkg
RUN if (!(Test-Path -Path $PROFILE)) { New-Item -Path $PROFILE -ItemType File -Force }; \
    Add-Content -Path $PROFILE -Value '$env:VCPKG_ROOT = \"C:\\workspace\\vcpkg\"'

ENTRYPOINT ["C:\\BuildTools\\Common7\\Tools\\VsDevCmd.bat", "&&", "pwsh", "-NoLogo", "-Command"]
CMD ["pwsh"]