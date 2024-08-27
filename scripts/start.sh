# this jar path is temporary
/bin/java -Xms2G -Xmx6G -XX:+UseG1GC -jar runtime/spigot*.jar nogui

passwd=$(cat ../scripts/etc/rcon-passwd)
sed -i "s/rcon.password=/rcon.password=$passwd/g" server.properties