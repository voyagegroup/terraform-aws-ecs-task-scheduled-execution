.PHONY: init
init:
	terraform $@

.PHONY: plan
plan: init
	terraform $@

.PHONY: apply
apply: init
	terraform $@

.PHONY: destroy
destroy:
	terraform $@

.PHONY: fmt
fmt:
	terraform $@

.PHONY: help
help:
	cat Makefile

.PHONY: docs
docs:
	$(MAKE) -f ../Makefile $@

