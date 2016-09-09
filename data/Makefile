NAME = local/data
VERSION = latest

.PHONY: all build

all: build

build:
	docker build -t $(NAME) --rm build/

clean:
	docker rmi $(NAME)
