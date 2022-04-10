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

.PHONY: build-docker-action
build-docker-action: action/action.Dockerfile action/action-entry-point.bash
	@set -euo pipefail
	cd action
	docker build -t cynnexis/expand-emoji:action -f action.Dockerfile .
	cd ..

.PHONY: version
version:
	@set -euo pipefail
	if [[ -x "${BUILD_BINARY}" ]]; then
		"${BUILD_BINARY}" --version
	else
		grep --max-count=1 -e 'APP_VERSION' expand-emoji.go | head -n1 | awk '{print $$NF;}' | sed -Ee 's/^\s*"\s*//;' -e 's/\s*"\s*$$//' -e 's/\s+//'
	fi
