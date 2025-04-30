#!make

### Constants
REGISTRY_DOMAIN := 123456.dkr.ecr.ap-northeast-1.amazonaws.com
REPOSITORY_NAME := bootstrap
REGION := ap-northeast-1
IMAGE_TAG := $(shell git describe --always --tag)

### Interpolations
IMAGE_NAME := $(REGISTRY_DOMAIN)/$(REPOSITORY_NAME)
IMAGE_TAG := $(shell git describe --always --tag)

.PHONY: help
help: ## displays this help screen.
	@grep -E '^[a-zA-Z._/-]+:.*?## .*$$' $(CURDIR)/Makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'


build:
	docker compose -f compose.dev.yml build

console:
	docker compose -f compose.dev.yml run --rm app bundle exec rails console

up:
	rm -rf tmp/pids/*
	touch tmp/caching-dev.txt
	docker compose -f compose.dev.yml up

stop:
	docker compose -f compose.dev.yml stop

down:
	docker compose -f compose.dev.yml down

install:
	docker compose -f compose.dev.yml run --rm app bundle install

lint:
	docker compose -f compose.dev.yml run --rm app bundle exec rubocop

rspec:
	docker compose -f compose.dev.yml run --rm app bundle exec rspec

lint-fix:
	docker compose -f compose.dev.yml run --rm app bundle exec rubocop -a

migrate:
	docker compose -f compose.dev.yml run --rm app bundle exec rails db:migrate

reset-db:
	docker compose -f compose.dev.yml run --rm app bundle exec rails db:migrate:reset db:seed

setup:
	docker compose -f compose.dev.yml run --rm app bundle exec rails db:drop db:create db:migrate db:seed

bash:
	docker compose -f compose.dev.yml exec app /bin/bash

test: lint rspec

all: build install setup

PHONY: aws.login
aws.login: ## login to AWS ECR
	aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${REGISTRY_DOMAIN}

PHONY: image.build
image.build: ## build docker image for production
	docker build --no-cache --target production -t ${IMAGE_NAME}:${IMAGE_TAG} .

PHONY: image.push
image.push: ## push image to docker registry
	@docker image push ${IMAGE_NAME}:${IMAGE_TAG}
