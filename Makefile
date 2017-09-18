.PHONY: build push docker

DOCKERFILE ?= ""

default: build

build:
	bin/build $(DOCKERFILE)

push:
	bin/push

docker: build push
