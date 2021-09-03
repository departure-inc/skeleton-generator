#!make

### Constants
REGISTRY_DOMAIN := example.com
REPOSITORY_NAME := bootstrap

### Interpolations
IMAGE_NAME := $(REGISTRY_DOMAIN)/$(REPOSITORY_NAME)
IMAGE_TAG := $(shell git describe --always --tag)

.PHONY: help
help: ## displays this help screen.
	@grep -E '^[a-zA-Z._/-]+:.*?## .*$$' $(CURDIR)/Makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'


build:
	docker-compose build

console:
	docker-compose run --rm app bundle exec rails console

up:
	rm -rf tmp/pids/*
	touch tmp/caching-dev.txt
	docker-compose up

stop:
	docker-compose stop

down:
	docker-compose down

install:
	docker-compose run --rm app bundle install
	docker-compose run --rm app yarn install

lint:
	docker-compose run --rm app bundle exec rubocop
	docker-compose run --rm app yarn lint
	docker-compose run --rm app yarn stylelint
	docker-compose run --rm app bundle exec slim-lint app/views/

rspec:
	docker-compose run --rm app bundle exec rspec

fix:
	docker-compose run --rm app bundle exec rubocop -a
	docker-compose run --rm app yarn lint --fix
	docker-compose run --rm app yarn stylelint --fix

migrate:
	docker-compose run --rm app bundle exec rails db:migrate

reset-db:
	docker-compose run --rm app bundle exec rails db:migrate:reset db:seed

setup:
	docker-compose run --rm app bundle exec rails db:drop db:create db:migrate db:seed

bash:
	docker-compose exec app /bin/bash

test: lint rspec

all: build install setup

PHONY: image.build
image.build: ## build docker image for production
	docker build --target production -t ${IMAGE_NAME}:${IMAGE_TAG} .

PHONY: image.push
image.push: ## push image to docker registry
	@docker image push ${IMAGE_NAME}:${IMAGE_TAG}
