#!/bin/sh
installer_version="${INSTALLER_VERSION:-0.8.0}"
server_version="${SERVER_VERSION:-1.17.1}"

wget -O installer.jar \
    https://maven.fabricmc.net/net/fabricmc/fabric-installer/${installer_version}/fabric-installer-${installer_version}.jar

java -jar installer.jar server -mcversion "${server_version}" -downloadMinecraft
rm installer.jar

echo "serverJar=server.jar" > fabric-server-launcher.properties
echo "eula=true" > eula.txt

java -jar fabric-server-launch.jar
