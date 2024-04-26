#!/bin/bash

while [ 1 ]
do
    curl ifconfig.me > public-ip.txt
    sleep 1440
done