echo "Starting server.."

cd runtime || exit
/bin/java -Xms2G -Xmx6G -XX:+UseG1GC -jar spigot*.jar nogui

passwd=$(cat home/mcadmin/scripts/etc/rcon-passwd)
sed -i "s/rcon.password=/rcon.password=$passwd/g" /home/mcserver/runtime/server.properties