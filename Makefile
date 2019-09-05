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

pull:
	docker pull google/cloud-sdk:latest
	docker pull google/cloud-sdk:slim
	docker pull google/cloud-sdk:alpine

version:
	docker run -it --rm --entrypoint=bash google/cloud-sdk:alpine gcloud version

