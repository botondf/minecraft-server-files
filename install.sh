#!/bin/bash

# ATTENTION:
# this script is meant to be run as root
# *MUST* be run from the git repo directory. please cd into to the git directory, whatever name was set during cloning
# Set executable permissions on install script, install.sh, located in the repo root, i.e. directory mentioned before:
# chmod u+x install.sh

grep https://github.com/botondf/ .git/config || exit
DIR=$(pwd) # get git repo dir path
#NAME=$(basename "$DIR") # get git repo dir name

groupadd minecraft

useradd mcserver -g minecraft -m -d /home/minecraft -l -s /sbin/nologin -c "Minecraft server user"
useradd mcutils -g minecraft -m -d /home/minecraft -l -s /bin/bash -c "Minecraft tools user"
loginctl enable-linger mcserver
loginctl enable-linger mcutils
cd /home/minecraft || exit

mv "$DIR"/runtime /home/minecraft/runtime || exit
mv "$DIR" /home/minecraft/ || exit

# temp disable
#apt-get update
#apt-get dist-upgrade -y
#apt-get install -y curl gcc make vim zip unzip rclone
#curl -O https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb
#dpkg -i jdk-21_linux-x64_bin.deb
#rm jdk-21_linux-x64_bin.deb
#apt-get clean

# /server was moved
# cd server || exit
cd /home/minecraft || exit
# temp disable
#git clone https://github.com/Tiiffi/mcrcon.git scripts/rcon
#make scripts/rcon/mcrcon

mkdir /home/minecraft/.config/systemd/user
cp systemd/services/mc*.service /home/minecraft/.config/systemd/user/
cp systemd/timers/mc*.timer /home/minecraft/.config/systemd/user/

cd /home/minecraft/.config/systemd/user/ || exit
systemctl enable mc.service mc-backup.service mc-backup-upload.service mc-ip.service mc-stop.service
systemctl daemon-reload
#cd systemd/timers || exit
systemctl enable mc.timer mc-backup.timer mc-ip.timer mc-stop.timer
systemctl daemon-reload
#cd systemd/services || exit
systemctl start mc.service mc-backup.service mc-backup-upload.service mc-ip.service
systemctl daemon-reload
#cd systemd/timers || exit
systemctl start mc.timer mc-backup.timer mc-ip.timer mc-stop.timer
systemctl daemon-reload

cd /home/minecraft/scripts/build || exit
# temp disable
#curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
#java -jar BuildTools.jar --rev latest
#mv spigot*.jar ../../runtime/

cd ../../runtime || exit
# temp disable
#java -XX:+UseG1GC -jar spigot*.jar nogui
#sed -i "s/false/true/g" eula.txt

cd /home/minecraft || exit
chown -R minecraft:minecraft .

cd /home/minecraft/server/scripts || exit
chmod u+x *.sh

exit