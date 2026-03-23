FROM mcr.microsoft.com/powershell:ubuntu-24.04

RUN apt-get update && \
    apt-get install -y git g++ clang clang-tools make ninja-build curl zip unzip tar pkg-config

RUN curl -L -o /tmp/cmake-4.2.3-linux-x86_64.sh \
    https://github.com/Kitware/CMake/releases/download/v4.2.3/cmake-4.2.3-linux-x86_64.sh && \
    chmod +x /tmp/cmake-4.2.3-linux-x86_64.sh && \
    /bin/sh /tmp/cmake-4.2.3-linux-x86_64.sh --skip-license --prefix=/usr/local && \
    rm -f /tmp/cmake-4.2.3-linux-x86_64.sh

RUN if [ -e /usr/bin/llvm-profdata-18 ] && [ ! -e /usr/bin/llvm-profdata ]; then \
      ln -s /usr/bin/llvm-profdata-18 /usr/bin/llvm-profdata; \
    fi || true && \
    if [ -e /usr/bin/llvm-cov-18 ] && [ ! -e /usr/bin/llvm-cov ]; then \
      ln -s /usr/bin/llvm-cov-18 /usr/bin/llvm-cov; \
    fi || true

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