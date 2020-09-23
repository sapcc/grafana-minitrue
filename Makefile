IMAGE:=keppel.eu-de-1.cloud.sap/ccloud/grafana-minitrue
IMAGE_GIT_SYNC:=keppel.eu-de-1.cloud.sap/ccloud/git-sync
VERSION:=v0.9.6
VERSION_GIT_SYNC:=v3.1.6

docker-build:
	docker build -t $(IMAGE):$(VERSION) .
	docker build -t $(IMAGE_GIT_SYNC):$(VERSION_GIT_SYNC) -f Dockerfile.git-sync .

docker-push: docker-build
	docker push $(IMAGE):$(VERSION)
	docker push $(IMAGE_GIT_SYNC):$(VERSION_GIT_SYNC)
