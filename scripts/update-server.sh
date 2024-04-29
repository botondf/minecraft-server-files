#!/bin/bash
./buildtools.sh
./stop
mv ../spigot*.jar build/old-servers/
./buildserver.sh
# SET REAL PATH