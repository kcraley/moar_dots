#!/usr/bin/make

.PHONY: all
all: install backup

.PHONY: install
install:
	/bin/sh install.sh

.PHONY: backup
backup:
	/bin/sh backup.sh
