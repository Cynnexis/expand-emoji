#!/usr/bin/make
ifneq (,$(wildcard ./.env))
	include .env
	export $(shell sed 's/=.*//' .env)
endif
SHELL=/bin/bash
BUILD_BINARY=expand-emoji
SOURCE_FILES := expand-emoji.go go.mod go.sum
.ONESHELL:

all: help

.PHONY: help
help:
	@echo -e "\tMakefile for expand-emoji"
	@echo ''
	@echo "  usage: $0 [COMMAND]"
	@echo ''
	@echo "The available commands are:"
	@echo ''
	@echo "  help         - Print this help text and exit."
	@echo "  tidy         - Tidy the project."
	@echo "  build        - Build the binary."
	@echo "  run          - Run the project. You can specify arguments through the environment variables ARGS."
	@echo "  build-docker - Build the Docker image cynnexis/expand-emoji."
	@echo "  version      - Print the version of the application."
	@echo ''

.PHONY: clean
clean:
	rm -f "${BUILD_BINARY}"

.PHONY: tidy
tidy:
	go mod tidy

${BUILD_BINARY}: ${SOURCE_FILES}

.PHONY: build
build:
	go build

.PHONY: run
run: ${BUILD_BINARY}
	@set -euo pipefail

	if [[ -v ARGS && -n $$ARGS ]]; then
		go run . $$ARGS
	else
		go run .
	fi

.PHONY: build-docker
build-docker: ${SOURCE_FILES} Dockerfile
	@set -euo pipefail
	PROJECT_VERSION=$$($(MAKE) version)
	docker build -t cynnexis/expand-emoji --build-arg PROJECT_VERSION .

.PHONY: version
version: "${BUILD_BINARY}"
	@set -euo pipefail
	"${BUILD_BINARY}" --version
