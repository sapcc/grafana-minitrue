FROM ubuntu:18.04

# docker image for adjusting the uids of grafana dashboards in canonical way
MAINTAINER Tilo Geissler, tilo.geissler@sap.com

# install some stuff
RUN apt-get update; apt-get install -y jq vim

ADD minitrue.sh /

#CMD ["./minitrue.sh"]
