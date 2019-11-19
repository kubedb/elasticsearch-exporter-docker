SHELL=/bin/bash -o pipefail

REGISTRY   ?= kubedb
BIN        := elasticsearch_exporter
IMAGE      := $(REGISTRY)/$(BIN)
DB_VERSION := 1.0.2
TAG        := $(shell git describe --exact-match --abbrev=0 2>/dev/null || echo "")

.PHONY: push
push: container
	docker push $(IMAGE):$(TAG)

.PHONY: container
container:
	docker pull justwatch/elasticsearch_exporter:$(DB_VERSION)
	docker tag justwatch/elasticsearch_exporter:$(DB_VERSION) $(IMAGE):$(TAG)

.PHONY: version
version:
	@echo ::set-output name=version::$(TAG)
