#!/bin/bash

grep https://github.com/botondf/ .git/config || exit
DIR=$(pwd) # get git repo dir path
#NAME=$(basename "$DIR") # get git repo dir name

useradd minecraft -m
cd /home/minecraft || exit

mv "$DIR" /home/minecraft/server || exit

apt-get update
apt-get dist-upgrade -y
apt-get install -y curl gcc make vim zip unzip rclone
curl -O https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb
dpkg -i jdk-21_linux-x64_bin.deb
rm jdk-21_linux-x64_bin.deb
apt-get clean

cd server || exit
git clone https://github.com/Tiiffi/mcrcon.git scripts/rcon
make scripts/rcon/mcrcon

cp systemd/services/mc*.service /etc/systemd/system
cp systemd/timers/mc*.timer /etc/systemd/system

cd /etc/systemd/system || exit
systemctl enable mc.service mc-backup.service mc-backup-upload.service mc-ip.service mc-stop.service
systemctl daemon-reload
cd systemd/timers || exit
systemctl enable mc.timer mc-backup.timer mc-ip.timer mc-stop.timer
systemctl daemon-reload
cd systemd/services || exit
systemctl start mc.service mc-backup.service mc-backup-upload.service mc-ip.service
systemctl daemon-reload
cd systemd/timers || exit
systemctl start mc.timer mc-backup.timer mc-ip.timer mc-stop.timer
systemctl daemon-reload

cd build || exit
curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
java -jar BuildTools.jar --rev latest
mv spigot*.jar ../../runtime/

cd ../../runtime || exit
java -XX:+UseG1GC -jar spigot*.jar nogui
sed -i "s/false/true/g" eula.txt

cd /home/minecraft || exit
chown -R minecraft:minecraft .

cd /home/minecraft/server/scripts || exit
chmod u+x *.sh

su minecraft

exit