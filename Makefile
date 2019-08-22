.PHONY: build push docker

default: build

build:
	bin/build

build-all:
	bin/build
	BASE=alpine bin/build
	BASE=slim bin/build

push:
	bin/push

docker: build push
