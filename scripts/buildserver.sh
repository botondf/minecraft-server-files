#!/bin/bash
cd .. #change dir to server dir to place server jar there
java -jar scripts/build/BuildTools.jar --rev latest
#mv build/spigot*.jar build/spigot.jar
# SET REAL PATH