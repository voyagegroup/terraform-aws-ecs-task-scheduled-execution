terraform-docs:
	which terraform-docs || go get -v github.com/segmentio/terraform-docs

.PHONY: docs
docs: terraform-docs
	terraform-docs markdown ./ > ./README.md.sample

.PHONY: fmt
fmt:
	terraform $@

.PHONY: help
help:
	cat Makefile


