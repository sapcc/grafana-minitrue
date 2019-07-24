#!/bin/sh

PATH_IN="/gitsync_in"
PATH_OUT="/gitsync_out"
SLEEP_TIME_IN_SEC=${SLEEP_TIME_IN_SEC:-60}

while true
do
  cd ${PATH_IN}
  ( set +eo pipefail ;  find . -name \*.json -print0 ; set -eo pipefail ) | while read -d $'\0' i; do
    echo ${i}
    NEW_UID=$(cat "${i}" | jq --raw-output .title | sed 's, -,-,g ; s,- ,-,g ; s, ,-,g' | tr '[:upper:]' '[:lower:]' | head -c 39)
    sed 's,"uid": .*,"uid": "'${NEW_UID}'",' ${i} > ../${PATH_OUT}/${i}
  done
  sleep ${SLEEP_TIME_IN_SEC}
done
