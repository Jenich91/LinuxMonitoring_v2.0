#!/bin/bash
. ./myLib.sh

# mkdir -p /test/
# sudo rm -rf /test/* #clean

sudo bash -c "touch log.txt"
checkArg $1 $2 $3 $4 $5 $6
StartGen

sudo bash -c "cat log.txt >> ../03/log.txt" # copy log to log for cleaner script

if [ $(dpkg-query -W -f='${Status}' nano 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  sudo bash -c "apt install tree -y"
else
  tree $1 --du --si --dirsfirst 2>/dev/null
fi
