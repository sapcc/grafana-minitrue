#!/bin/bash

PATH_IN=${PATH_IN:-/gitsync_in/grafana-content}
PATH_OUT=${PATH_OUT:-/minitrue_out/grafana-content}
SLEEP_TIME_IN_SEC=${SLEEP_TIME_IN_SEC:-60}

# wait until gitsync did its initial sync
while [ ! -d ${PATH_IN}/datasources-config ]; do
  echo "waiting 5 more seconds for the grafana-content to be mounted and synced via git-sync ..."
  sleep 5
done

# ensure existance of out dirs
cd ${PATH_IN}
mkdir -p ${PATH_OUT}
for i in $(find * -type d); do
  mkdir -p ${PATH_OUT}/${i}
done

# copy over the datasource and dashboard provisioning config
cp datasources-config/* ${PATH_OUT}/datasources-config
for i in dashboards-config* ; do
  cp ${i}/* ${PATH_OUT}/${i}
done

# loop and convert
while true; do
  DATE=`date`
  echo "$DATE - rewriting dashboard urls"
  cd ${PATH_IN}
  ( set +eo pipefail ;  find . -name \*.json -print0 ; set -eo pipefail ) | while read -d $'\0' i; do
#    echo ${i}
    # check if this is a global dashboard - they should keep their hashed url
    echo $i | grep -q '^./dashboards-Global/'
    if [ "$?" != "0" ]; then
      NEW_UID=$(cat "${i}" | jq --raw-output .title | sed 's, -,-,g ; s,- ,-,g ; s, ,-,g' | tr '[:upper:]' '[:lower:]' | head -c 39)
      # first is to replace the uid with the new one and second to adjust all url links referenced in the dashboard itself
      sed 's,"uid": .*,"uid": "'${NEW_UID}'"\,,;s,"url": "/d/.*/,"url": "/d/,g' "${i}" > "${PATH_OUT}/${i}"
    else
      # no rewriting of the dashboard uid for a better url for global dashboards
      cat "${i}" > "${PATH_OUT}/${i}"
    fi
  done
  # remove target dashboards which are gone in the source
  cd ${PATH_OUT}
  ( set +eo pipefail ;  find . -name \*.json -print0 ; set -eo pipefail ) | while read -d $'\0' i; do
#    echo ${i}
    if [ ! -f "${PATH_IN}/${i}" ]; then
      rm -f "${i}"
    fi
  done
  sleep ${SLEEP_TIME_IN_SEC}
done
