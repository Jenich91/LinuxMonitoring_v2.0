#!/bin/bash

path=''../04/''
filePath=`bash -c "sudo find $path -type f -name "*.log" | head -n5"`

# Написать bash-скрипт для разбора логов nginx из Части 4 через awk.
# Скрипт запускается с 1 параметром, который принимает значение 1, 2, 3 или 4.

# проверка на число и непустоту переменной
if [[ $1 =~ ^[0-9]+$ ]];then
    mode=$1
else
    echo "ERROR: Argument№1 \"$1\" contains non numerical value or is empty input"
    exit
fi
if [[ ! $mode > 0 || ! $mode -le 4 ]]; then 
    echo "ERROR: Argument№1 \"$1\" has an invalid range "
    exit
fi

GREEN='\033[01;32m'
NONE='\033[0m'
# В зависимости от значения параметра вывести:
if [[ $mode -eq 1 ]];then # Все записи, отсортированные по коду ответа
echo "sort by response code"
awk '{print $0 | "sort -k 9 -t\047 \047 -n"}' $filePath | awk -v g=$GREEN -v n=$NONE '{for(i=1;i<=8;i++) printf $i" "; printf("%s %s\n", g substr($0,index($0,$9),3)n, substr($0,index($0,$10)))}'
elif [[ $mode -eq 2 ]];then # Все уникальные IP, встречающиеся в записях
echo "only uniq IP"
    awk '{ if (!($1 in a)) a[$1] = $0; } END { for (i in a) print a[i]}' $filePath | awk -v g=$GREEN -v n=$NONE '{printf("%s ", g$1n); for(i=2;i<=NF-1;i++) printf $i" "; print ""}'
elif [[ $mode -eq 3 ]];then # Все запросы с ошибками (код ответа - 4хх или 5хх)
echo "request with error"
    awk -e '$9 ~ /^[4-5]../ {print $0}' $filePath | awk -v g=$GREEN -v n=$NONE '{for(i=1;i<=8;i++) printf $i" "; printf("%s %s\n", g substr($0,index($0,$9),3)n, substr($0,index($0,$10)))}'
elif [[ $mode -eq 4 ]];then # Все уникальные IP, которые встречаются среди ошибочных запросов
echo "only uniq IP among error request "
    sort -u -k 1,1 $filePath | awk -e '$9 ~ /^[4-5]../ {print $0 | "sort -u"}' | awk -v g=$GREEN -v n=$NONE '{printf("%s ", g$1n); for(i=2;i<=8;i++) printf $i" "; printf("%s %s\n", g substr($0,index($0,$9),3)n, substr($0,index($0,$10)))}'
fi
