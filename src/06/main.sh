#!/bin/bash
# Для установки запускаем -> bash installGoAccess.sh
path=''../04/''
logpath=`find $path -type f -name "*.log" | head -n5`

# проверка на число и непустоту переменной
if [[ $1 =~ ^[0-9]+$ ]];then
    mode=$1
else
    echo "ERROR: Argument№1 \"$1\" contains non numerical value"
    exit
fi
if [[ ! $mode > 0 || ! $mode -le 4 ]]; then 
    echo "ERROR: Argument№1 \"$1\" has an invalid range "
    exit
fi

# В зависимости от значения параметра вывести:
if [[ $mode -eq 1 ]];then # Все записи, отсортированные по коду ответа
    sudo goaccess $logpath -o stat.html --sort-panel=STATUS_CODES,BY_DATA,ASC -p goaccess.conf \
    --ignore-panel=VISITORS \
    --ignore-panel=REQUESTS \
    --ignore-panel=REQUESTS_STATIC \
    --ignore-panel=OS \
    --ignore-panel=HOSTS \
    --ignore-panel=BROWSERS \
    --ignore-panel=VISIT_TIMES \
    --ignore-panel=REFERRING_SITES \
    --ignore-panel=KEYPHRASES \
    --ignore-panel=REMOTE_USER \
    --ignore-panel=CACHE_STATUS \
    --ignore-panel=GEO_LOCATION \
    --ignore-panel=MIME_TYPE \
    --ignore-panel=TLS_TYPE \
    --ignore-panel=NOT_FOUND

elif [[ $mode -eq 2 ]];then # Все уникальные IP, встречающиеся в записях
    sudo goaccess $logpath -o stat.html -p goaccess.conf \
    --ignore-panel=VISITORS \
    --ignore-panel=REQUESTS \
    --ignore-panel=REQUESTS_STATIC \
    --ignore-panel=OS \
    --ignore-panel=BROWSERS \
    --ignore-panel=VISIT_TIMES \
    --ignore-panel=REFERRING_SITES \
    --ignore-panel=KEYPHRASES \
    --ignore-panel=REMOTE_USER \
    --ignore-panel=CACHE_STATUS \
    --ignore-panel=GEO_LOCATION \
    --ignore-panel=MIME_TYPE \
    --ignore-panel=TLS_TYPE \
    --ignore-panel=STATUS_CODES \
    --ignore-panel=NOT_FOUND


elif [[ $mode -eq 3 ]];then # Все запросы с ошибками (код ответа - 4хх или 5хх)
    sudo goaccess $logpath -o stat.html --ignore-status=200 --ignore-status=201 -p goaccess.conf \
    --ignore-panel=VISITORS \
    --ignore-panel=REQUESTS \
    --ignore-panel=REQUESTS_STATIC \
    --ignore-panel=OS \
    --ignore-panel=HOSTS \
    --ignore-panel=BROWSERS \
    --ignore-panel=VISIT_TIMES \
    --ignore-panel=REFERRING_SITES \
    --ignore-panel=KEYPHRASES \
    --ignore-panel=REMOTE_USER \
    --ignore-panel=CACHE_STATUS \
    --ignore-panel=GEO_LOCATION \
    --ignore-panel=MIME_TYPE \
    --ignore-panel=TLS_TYPE \
    --ignore-panel=NOT_FOUND

elif [[ $mode -eq 4 ]];then # Все уникальные IP, которые встречаются среди ошибочных запросов
    sudo goaccess $logpath -o stat.html --ignore-status=200 --ignore-status=201 -p goaccess.conf \
    --ignore-panel=VISITORS \
    --ignore-panel=REQUESTS \
    --ignore-panel=REQUESTS_STATIC \
    --ignore-panel=OS \
    --ignore-panel=BROWSERS \
    --ignore-panel=VISIT_TIMES \
    --ignore-panel=REFERRING_SITES \
    --ignore-panel=KEYPHRASES \
    --ignore-panel=REMOTE_USER \
    --ignore-panel=CACHE_STATUS \
    --ignore-panel=GEO_LOCATION \
    --ignore-panel=MIME_TYPE \
    --ignore-panel=TLS_TYPE \
    --ignore-panel=STATUS_CODES \
    --ignore-panel=NOT_FOUND
fi
