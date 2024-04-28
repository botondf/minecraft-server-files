#!/bin/bash
pwd=$(cat etc/rcon-pwd)

build/mcrcon -H localhost -P 25575 -p $pwd stop
#SET REAL PATH

while kill -0 $MAINPID 2>/dev/null
do
  sleep 0.5
done
