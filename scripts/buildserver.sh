#!/bin/bash
cd ../scripts/build #change dir to server dir to place server jar there
java -jar BuildTools.jar --rev latest
mv spigot*.jar ../../server/spigot.jar
# SET REAL PATH