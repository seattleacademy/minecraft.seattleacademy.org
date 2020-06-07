#!/bin/bash

function rcon {
  /opt/minecraft/tools/mcrcon/mcrcon -H 127.0.0.1 -P 25575 -p '#1234567890' "$1"
}
thedate=$(date +%F-%H-%M)
rcon "save-off"
rcon "save-all"
tar -cvpzf /opt/minecraft/backups/server-"$thedate".tar.gz /opt/minecraft/server
rcon "save-on"
#rm -rf /opt/minecraft/oldmathworld
#mv /opt/minecraft/mathworld /opt/minecraft/oldmathworld
#scp -P 3389 -r minecraft@math.seattleacademy.org:/opt/minecraft/server/world /opt/minecraft/mathworld
scp -P 3389 -r /opt/minecraft/backups/server-"$thedate".tar.gz minecraft@math.seattleacademy.org:/opt/minecraft/backups/minecraftserver-"$thedate".tar.gz

## Delete older backups
find /opt/minecraft/backups/ -type f -mtime +7 -name '*.gz' -delete

