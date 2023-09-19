FROM mcr.microsoft.com/powershell:ubuntu-22.04

RUN apt-get update && \
    apt-get install -y git g++ make cmake curl zip unzip tar pkg-config

ARG USER_ID=1000
ARG GROUP_ID=1000

RUN groupadd --gid ${GROUP_ID} build && \
    useradd --create-home --gid ${GROUP_ID} --uid ${USER_ID} build
USER build

WORKDIR /home/build/workspace

SHELL ["pwsh", "-NoLogo", "-NoProfile", "-NonInteractive", "-Command"]

COPY --chown=build ./scripts/Bootstrap.ps1 .
RUN ./Bootstrap.ps1 -VcpkgPath /home/build/workspace/vcpkg
RUN if (!(Test-Path -Path $PROFILE)) { New-Item -Path $PROFILE -ItemType File -Force }; \
    Add-Content -Path $PROFILE -Value '$env:VCPKG_ROOT = "/home/build/workspace/vcpkg"'

ENTRYPOINT ["pwsh", "-NoLogo", "-Command"]
CMD ["pwsh"]