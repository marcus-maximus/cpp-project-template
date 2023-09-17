FROM mcr.microsoft.com/powershell:ubuntu-22.04

RUN apt-get update && \
    apt-get install -y git g++ cmake curl unzip tar

ARG USER_ID=1000
ARG GROUP_ID=1000

RUN groupadd --gid ${GROUP_ID} build && \
    useradd --create-home --gid ${GROUP_ID} --uid ${USER_ID} build
USER build

WORKDIR /home/build/workspace

COPY --chown=build ./scripts/Bootstrap.ps1 .
RUN pwsh -Command './Bootstrap.ps1 -VcpkgPath /home/build/workspace/vcpkg \
    && [Environment]::SetEnvironmentVariable("VCPKG_ROOT", "/home/build/workspace/vcpkg", [System.EnvironmentVariableTarget]::User)'

ENTRYPOINT ["pwsh", "-NoLogo", "-NoProfile", "-Command"]
CMD ["pwsh"]