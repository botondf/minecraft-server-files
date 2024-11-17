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
useradd minecraft -g minecraft -m -l -s /sbin/nologin -c "Minecraft server user"
loginctl enable-linger minecraft

mv "$DIR"/* /home/minecraft/ || exit

# temp disable
#apt-get update
#apt-get dist-upgrade -y
#apt-get install -y curl gcc make vim zip unzip rclone
#curl -O https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb
#dpkg -i jdk-21_linux-x64_bin.deb
#rm jdk-21_linux-x64_bin.deb
#apt-get clean

cd /home/minecraft/ || exit
# temp disable
#git clone https://github.com/Tiiffi/mcrcon.git scripts/rcon
#make scripts/rcon/mcrcon

# this seems no not be performed properly - dir not found
mkdir /home/minecraft/.config/systemd/user
mv /home/minecraft/systemd/services/mc*.service /home/minecraft/.config/systemd/user
mv /home/minecraft/systemd/timers/mc*.timer /home/minecraft/.config/systemd/user

systemctl --user /home/minecraft/.config/systemd/user/mc.service
systemctl --user /home/minecraft/.config/systemd/user/mc.timer

systemctl --user /home/minecraft/.config/systemd/user/mc-backup.service
systemctl --user /home/minecraft/.config/systemd/user/mc-backup.timer

systemctl --user /home/minecraft/.config/systemd/user/mc-backup-upload.service

systemctl --user /home/minecraft/.config/systemd/user/mc-ip.service
systemctl --user /home/minecraft/.config/systemd/user/mc-ip.timer

systemctl --user /home/minecraft/.config/systemd/user/mc-stop.service
systemctl --user /home/minecraft/.config/systemd/user/mc-stop.timer

systemctl --user daemon-reload

cd /home/minecraft/scripts/build || exit
# temp disable
#curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
#java -jar BuildTools.jar --rev latest
#mv spigot*.jar ../../runtime/


cd /home/minecraft/runtime || exit
# temp disable
#java -XX:+UseG1GC -jar spigot*.jar nogui
#sed -i "s/false/true/g" eula.txt

cd /home/minecraft/ || exit
chown -R minecraft:minecraft .

cd /home/minecraft/scripts || exit
chmod u+x *.sh

exit