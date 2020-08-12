SHELL=/bin/bash -o pipefail

REGISTRY   ?= kubedb
BIN        := elasticsearch_exporter
IMAGE      := $(REGISTRY)/$(BIN)
EXPORTER_VERSION := 1.1.0
TAG        := $(shell git describe --exact-match --abbrev=0 2>/dev/null || echo "")

.PHONY: push
push: container
	docker push $(IMAGE):$(TAG)

.PHONY: container
container:
	docker pull justwatch/elasticsearch_exporter:$(EXPORTER_VERSION)
	docker tag justwatch/elasticsearch_exporter:$(EXPORTER_VERSION) $(IMAGE):$(TAG)

.PHONY: version
version:
	@echo ::set-output name=version::$(TAG)
