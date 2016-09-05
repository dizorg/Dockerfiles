NAME = local/alpine-sdk
VERSION = latest

.PHONY: all build

all: build build-sdk

build:
	docker build -t local/alpine:3.4 --rm build/

build-sdk:
	docker build -t $(NAME):$(VERSION) --rm build-sdk/

clean:
	docker rmi alpine:3.4
