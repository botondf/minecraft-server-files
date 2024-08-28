#!/bin/bash

apt-get update
apt-get dist-upgrade -y
apt-get install -y curl gcc make vim zip unzip rclone
curl -O https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb
dpkg -i jdk-21_linux-x64_bin.deb
rm jdk-21_linux-x64_bin.deb
apt-get clean

useradd minecraft -m

cd /home/minecraft || exit
git clone https://github.com/botondf/minecraft-server-files.git server

cd /home/minecraft/server || exit
git clone https://github.com/Tiiffi/mcrcon.git scripts/rcon
make scripts/rcon/mcrcon

cd /home/minecraft || exit
chown -R minecraft:minecraft .

cd /home/minecraft/server/scripts || exit
chmod u+x *.sh

cd /home/minecraft/server/systemd/services || exit
systemctl enable mc.service mc-backup.service mc-backup-upload.service mc-ip.service mc-stop.service
systemctl daemon-reload

cd /home/minecraft/server/systemd/timers || exit
systemctl enable mc.timer mc-backup.timer mc-ip.timer mc-stop.timer
systemctl daemon-reload

cd /home/minecraft/server/systemd/services || exit
systemctl start mc.service mc-backup.service mc-backup-upload.service mc-ip.service
systemctl daemon-reload

cd /home/minecraft/server/systemd/timers || exit
systemctl start mc.timer mc-backup.timer mc-ip.timer mc-stop.timer
systemctl daemon-reload

su minecraft
cd /home/minecraft/server/scripts || exit
./buildtools.sh
./buildserver.sh
cd /home/minecraft/server || exit