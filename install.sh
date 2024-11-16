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

useradd mcadmin -g minecraft -m -l -s /bin/bash -c "Minecraft administrator user"
useradd mcserver -g minecraft -m -l -s /sbin/nologin -c "Minecraft server user"
loginctl enable-linger mcserver
loginctl enable-linger mcadmin

#cd /home/mcadmin || exit

mv "$DIR"/runtime /home/mcserver/ || exit
mv "$DIR"/* /home/mcadmin/ || exit
# this moves runtime outside minecraft-server-files

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
cd /home/mcadmin || exit
# temp disable
#git clone https://github.com/Tiiffi/mcrcon.git scripts/rcon
#make scripts/rcon/mcrcon

# this seems no not be performed properly - dir not found
#mkdir /home/mcadmin/.config/systemd/user
#cp systemd/services/mc*.service .config/systemd/user/
#cp systemd/timers/mc*.timer .config/systemd/user/

systemctl enable /home/mcadmin/systemd/services/mc*.service
systemctl daemon-reload

systemctl enable /home/mcadmin/systemd/services/mc*.timer
systemctl daemon-reload

systemctl start /home/mcadmin/systemd/services/mc*.service
systemctl daemon-reload

systemctl start /home/mcadmin/systemd/services/mc*.timer
systemctl daemon-reload

cd /home/mcadmin/scripts/build || exit
# temp disable
#curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
#java -jar BuildTools.jar --rev latest
#mv spigot*.jar ../../runtime/


cd /home/mcserver/runtime || exit
# temp disable
#java -XX:+UseG1GC -jar spigot*.jar nogui
#sed -i "s/false/true/g" eula.txt

cd /home/mcserver/ || exit
chown -R mcserver:minecraft .

cd /home/mcadmin/scripts || exit
chmod u+x *.sh

exit