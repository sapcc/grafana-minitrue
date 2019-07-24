IMAGE   ?= sapcc/grafana-minitrue
VERSION = $(shell git rev-parse --verify HEAD | head -c 8)
SRCDIRS  := .

docker-build: tests bin/linux/$(BINARY)
	docker build -t $(IMAGE):$(VERSION) .

docker-push: build
	docker push $(IMAGE):$(VERSION)
