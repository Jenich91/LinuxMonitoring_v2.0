#!/bin/bash
. ./myLib.sh

checkArg $1
echo -e "before -> `df -h /`\n"
if [[ $mode = 1 ]]; then
    LogFileClearing
elif [[ $mode = 2 ]]; then
    DateTimeClearing
elif [[ $mode = 3 ]]; then
    NameMaskClearing $2
fi

echo "after -> `df -h /`"
sudo bash -c "> log.txt"

## очистка логов из задания 1, 2
# sudo bash -c "> ../01/log.txt" 
# sudo bash -c "> ../02/log.txt"