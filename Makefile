IMAGE:=hub.global.cloud.sap/monsoon/grafana-minitrue
VERSION:=v0.8.0

docker-build:
	docker build -t $(IMAGE):$(VERSION) .

docker-push: docker-build
	docker push $(IMAGE):$(VERSION)
