#!/usr/bin/make
.SILENT:
.PHONY: help
DC=docker-compose
RUN=$(DC) run --rm php-fpm
COMPOSER_BIN=~/.composer/vendor/bin
VENDOR_BIN=./vendor/bin
## Colors
COLOR_RESET   = \033[0m
COLOR_INFO  = \033[32m
COLOR_COMMENT = \033[33m
SHELL := /bin/bash

## List Targets and Descriptions
help:
	printf "${COLOR_COMMENT}Usage:${COLOR_RESET}\n"
	printf " make [target]\n\n"
	printf "${COLOR_COMMENT}Available targets:${COLOR_RESET}\n"
	awk '/^[a-zA-Z\-\_0-9\.@]+:/ { \
	helpMessage = match(lastLine, /^## (.*)/); \
	if (helpMessage) { \
	helpCommand = substr($$1, 0, index($$1, ":")); \
	helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
	printf " ${COLOR_INFO}%-16s${COLOR_RESET} %s\n", helpCommand, helpMessage; \
	} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

#Go to the bash container of the application
bash:
	@$(RUN) bash
	printf "${COLOR_COMMENT}Container removed.${COLOR_RESET}\n"
