CHART ?= fw-demo
TEST_VALUES := ./$(CHART)/tests/minimal.values.yaml
KUBE_VERSION := 1.29.1
POLICY_DIR := ./policies/

## This Makefile lacks a lot of necessary checks and only serves demonstrative purposes.

## Also, this Makefile uses binaries installed directly. In the real life you may want to use Docker for portability.

deps:
	@helm dep up $(CHART)

template:
	@echo "Running Helm Template"
	@helm template $(CHART) ./$(CHART) --values $(TEST_VALUES) 1>/dev/null; \
		if [ $$? -eq 0 ]; then \
			echo "Helm template passed"; \
		else \
			echo "Helm template failed"; \
			exit 1; \
		fi
	@echo

lint:
	@echo "Running Helm Lint"
	@helm lint $(CHART) --values $(TEST_VALUES)
	@echo

conformance:
	@echo "Running Conformance Checks"
	@helm template $(CHART) $(CHART) \
		--namespace $(CHART) \
		--kube-version $(KUBE_VERSION) \
		--values $(TEST_VALUES) | \
	kubeconform --summary -ignore-missing-schemas -kubernetes-version $(KUBE_VERSION)
	@echo

policy:
	@echo "Run Kyverno policy check"
	@helm template $(CHART) $(CHART) \
		--namespace $(CHART) \
		--kube-version $(KUBE_VERSION) \
		--values $(TEST_VALUES) | \
	kyverno apply $(POLICY_DIR) -r -
	@echo

unittest:
	@helm unittest $(CHART)

test: deps template lint conformance policy unittest

.PHONY: deps template lint conformance policy unittest test
