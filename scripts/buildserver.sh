#!/bin/bash
cd build || exit #change dir to server dir to place server jar there
java -jar BuildTools.jar --rev latest
mv spigot*.jar ../../runtime/

cd ../../runtime || exit
java -XX:+UseG1GC -jar spigot*.jar nogui
sed -i "s/false/true/g" eula.txt

## remove:
#passwd=$(cat ../scripts/etc/rcon-passwd)
#sed -i "s/rcon.password=/rcon.password=$passwd/g" server.properties