#!/bin/bash

PATH_IN=${PATH_IN:-/gitsync_in/grafana-content}
PATH_OUT=${PATH_OUT:-/minitrue_out/grafana-content}
SLEEP_TIME_IN_SEC=${SLEEP_TIME_IN_SEC:-60}

# ensure existance of out dirs
cd ${PATH_IN}
mkdir -p ${PATH_OUT}
for i in $(find dashboards-* -type d); do
  mkdir -p ${PATH_OUT}/$i
done

# loop and convert
while true
do
  ( set +eo pipefail ;  find . -name \*.json -print0 ; set -eo pipefail ) | while read -d $'\0' i; do
    echo ${i}
    NEW_UID=$(cat "${i}" | jq --raw-output .title | sed 's, -,-,g ; s,- ,-,g ; s, ,-,g' | tr '[:upper:]' '[:lower:]' | head -c 39)
    sed 's,"uid": .*,"uid": "'${NEW_UID}'",' ${i} > ${PATH_OUT}/${i}
  done
  sleep ${SLEEP_TIME_IN_SEC}
done
