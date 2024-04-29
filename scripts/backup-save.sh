#!/bin/bash
passwd=$(cat etc/rcon-passwd)
rcon/mcrcon/mcrcon -H localhost -P 25575 -p $passwd "say Starting backup..." save-off
rcon/mcrcon/mcrcon -H localhost -P 25575 -p $passwd save-all

count=$(ls -l ../backups | grep -c "^backup.*\.zip$") # grep warning: non-alphanum

if [ $count -gt 10 ]; then
  oldest=$(ls -lt ../backups | grep "^backup.*\.zip$" | tail -n 1) # grep warning: non-alphanum
  rm ../backups/"$oldest"
  echo "Deleted $oldest"
fi

# WORKING DIR: server/scripts: .. -> server, and so: ../backups -> server/backups
zip -r ../backups/$"backup-$(date +"%m-%d-%Y")" ../world* ../plugins/ImageFrame
#e.g. backup-2024-04-28.zip, of all files/directories in server directory (with spigot.jar) starting with world
#SET REAL PATH
rcon/mcrcon/mcrcon -H localhost -P 25575 -p $passwd save-on "say Backup complete."

# enable rcon via changing Minecraft server.properties lines:
# enable-rcon=true
# rcon.port=25575
# rcon.password=your_rcon_pasword