CLUSTER ?= "kind-helm-charts"
TAG ?= "dev"

all: kind

.PHONY: kind
kind:
	kind create cluster --name $(CLUSTER) --config kind/kind.config.yaml

.PHONY: kind-delete
kind-delete:
	kind delete cluster --name $(CLUSTER)

.PHONY: lint-katalog-agent
lint-katalog-agent:
	helm lint charts/katalog-agent

.PHONY: lint-katalog
lint-katalog:
	helm lint charts/katalog

.PHONY: lint-ip
lint-ip:
	helm lint charts/ip

.PHONY: lint-versitygw
lint-versitygw:
	helm lint charts/versitygw

.PHONY: keda
keda:
	helm install keda kedacore/keda --namespace keda --create-namespace