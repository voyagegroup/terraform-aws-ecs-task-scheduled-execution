.PHONY: docs
docs:
	docker run --rm \
      -v $(PWD):/data \
      cytopia/terraform-docs \
      terraform-docs-012 --sort-by-required md . > README.md.sample

.PHONY: fmt
fmt:
	terraform $@

.PHONY: help
help:
	cat Makefile

