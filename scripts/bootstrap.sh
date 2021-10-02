#!/bin/sh
installer_version="${INSTALLER_VERSION:-0.8.0}"
server_version="${SERVER_VERSION:-1.17.1}"
world_dir="${WORLD_DIR:-minecraft}"

# Downlod fabric installer
wget -O installer.jar \
    https://maven.fabricmc.net/net/fabricmc/fabric-installer/${installer_version}/fabric-installer-${installer_version}.jar

# Download minecraft
java -jar installer.jar server -mcversion "${server_version}" -downloadMinecraft
rm installer.jar

# Configure fabric, and accept minecraft EULA
echo "serverJar=server.jar" > fabric-server-launcher.properties
echo "eula=true" > eula.txt

# TODO: Download mods

# TODO: Download world save from Cloud Storage

# Add world save when getting SIGTERM
# https://cloud.google.com/run/docs/reference/container-contract#instance-shutdown
mkdir -p "${world_dir}"
on_term() {
    local filename="${1:-worldsave.tar.gz}"
    tar --exclude "${world_dir}/mods" -zcf "${filename}" "${world_dir}"
    # TODO: Upload to Cloud Storage
    trap - EXIT
    kill -s EXIT ${$}
}
trap on_term SIGTERM

# Start the server
java -jar fabric-server-launch.jar -dir "${world_dir}"
