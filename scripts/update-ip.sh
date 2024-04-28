#!/bin/bash
fetched=$(curl -4 ifconfig.me)
saved=$(cat etc/public-ip)

if [ "$fetched" != "$saved" ]
then
  sed -i "s/$saved/$fetched/g" config/config.yml # SET REAL PATH
  sed -i "s/$saved/$fetched/g" config/messages.yml # SET REAL PATH
  echo "$fetched" > etc/public-ip
fi