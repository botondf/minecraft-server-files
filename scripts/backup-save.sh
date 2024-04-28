#!/bin/bash
build/mcrcon -H localhost -P 25575 -p $pwd save-off
# SET REAL PATH
build/mcrcon -H localhost -P 25575 -p $pwd save-all

zip -r "backup-$(date +"%m-%d-%Y")" survival/world*
#e.g. backup-2024-04-28.zip, of all files/directories in server directory (with spigot.jar) starting with world
#SET REAL PATH

build/mcrcon -H localhost -P 25575 -p $pwd save-on
