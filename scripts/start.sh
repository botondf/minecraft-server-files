echo "Starting server.."
cd runtime || exit
/bin/java -Xms2G -Xmx6G -XX:+UseG1GC -jar spigot*.jar nogui

passwd=$(cat ../scripts/etc/rcon-passwd)
sed -i "s/rcon.password=/rcon.password=$passwd/g" server.properties