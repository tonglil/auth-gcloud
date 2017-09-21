.PHONY: build push docker

default: build

build:
	bin/build

push:
	bin/push

docker: build push
