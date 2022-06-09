FROM ubuntu:22.04
LABEL source_repository="https://github.com/sapcc/grafana-minitrue"

# docker image for adjusting the uids of grafana dashboards in canonical way
MAINTAINER Tilo Geissler, tilo.geissler@sap.com

# install some stuff
RUN apt-get update; apt-get install -y jq vim

ADD minitrue.sh /

#CMD ["./minitrue.sh"]
