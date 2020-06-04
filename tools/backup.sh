#!/bin/bash

function rcon {
  /opt/minecraft/tools/mcrcon/mcrcon -H 127.0.0.1 -P 25575 -p '#1234567890' "$1"
}

rcon "save-off"
rcon "save-all"
tar -cvpzf /opt/minecraft/backups/server-$(date +%F-%H-%M).tar.gz /opt/minecraft/server
rcon "save-on"
rm -rf /opt/minecraft/oldmathworld
mv /opt/minecraft/mathworld /opt/minecraft/oldmathworld
scp -P 3389 -r minecraft@math.seattleacademy.org:/opt/minecraft/server/world /opt/minecraft/mathworld

## Delete older backups
find /opt/minecraft/backups/ -type f -mtime +700 -name '*.gz' -delete

