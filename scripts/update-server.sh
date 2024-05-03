#!/bin/bash
./buildtools.sh
./stop
# backup old server jar in case of issues
mv ../runtime/spigot*.jar build/old-servers/

#./buildserver.sh replacement because need to run server with --forceUpgrade
cd build
java -jar BuildTools.jar --rev latest
mv spigot*.jar ../runtime/

cd ../../runtime/
# run once to upgrade world
java -Xms2G -Xmx6G -XX:+UseG1GC -jar spigot*.jar nogui --forceUpgrade
# new jar may need to change eula
sed -i "s/eula=false/eula=true/g" eula.txt
# run server with new world to check if it works
java -Xms2G -Xmx6G -XX:+UseG1GC -jar spigot*.jar nogui
# stop the server (this is an unserviced run)
./stop