
IMAGE:=hub.global.cloud.sap/monsoon/grafana-minitrue
VERSION:=v0.0.1
#VERSION:=latest
#VERSION:=v0.0.3

docker-build:
	docker build -t $(IMAGE):$(VERSION) .

docker-push:
	docker push $(IMAGE):$(VERSION)
