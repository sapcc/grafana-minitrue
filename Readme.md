# minitrue

The Ministry of Truth (Newspeak: Minitrue) is the ministry of propaganda. As with the other ministries in the novel (1984), the name Ministry of Truth is a misnomer because in reality it serves the opposite: it is responsible for any necessary falsification of historical events.

## purpose

minitrue in CCloud EE does a Grafana Dashboard Unique ID (uid) replacement.

why: with Grafana 6 the uid is key in the url path.
impact: To have a human understandable id and to avoid massive link fixing in the system we do an auto replacement of the system generated id by the origin name.    

## details

There are 2 Directories which will be mounted to the minitrue container

  1. /gitsync_in - filled by gitsync sidecar from git frequently
  2. /grafana_out - read by Grafana as Dashboard input directory

Flow: read all Grafana Dashboards from /gitsync_in -> modifiy `uid` field, based on dashboard `title` -> write to grafana_out

## RUN

1. docker build . -t plutono-minitrue
2. docker run plutono-minitrue
