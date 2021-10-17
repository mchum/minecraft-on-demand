#!/bin/sh
installer_version="${INSTALLER_VERSION:-0.8.0}"
server_version="${SERVER_VERSION:-1.17.1}"

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

# TODO: Add world save when exiting
# https://cloud.google.com/run/docs/reference/container-contract#instance-shutdown
on_exit() {
    ls -lR /fabric
    trap - EXIT
    kill -s EXIT ${$}
}
trap on_exit EXIT

# Start the server
java -jar fabric-server-launch.jar --nogui
