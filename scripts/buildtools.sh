#!/bin/bash
curl -o build/BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar && java -jar build/BuildTools.jar
# SET REAL PATH FOR BUILD TOOLS