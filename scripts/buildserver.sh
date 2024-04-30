#!/bin/bash
cd ../scripts/build #change dir to server dir to place server jar there
java -jar BuildTools.jar --rev latest
mv spigot*.jar ../../runtime/spigot.jar
# SET REAL PATH