#!/bin/bash
fetched=$(curl -4 ifconfig.me)
saved=$(cat etc/public-ip)

if [ "$fetched" != "$saved" ]
then
  sed -i "s/$saved/$fetched/g" ../plugins/DiscordSRV/config.yml # SET REAL PATH
  sed -i "s/$saved/$fetched/g" ../plugins/DiscordSRV/messages.yml # SET REAL PATH
  echo "$fetched" > etc/public-ip
fi

passwd=$(cat etc/rcon-passwd)
rcon/mcrcon/mcrcon -H localhost -P 25575 -p $passwd "discord reload" "discord bcast IP updated."