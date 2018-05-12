#!/usr/bin/env make

.PHONY: all
all: install backup

.PHONY: install
install:
	/bin/bash install.sh

.PHONY: backup
backup:
	/bin/bash backup.sh

.PHONY: restore
restore:
	/bin/bash restore.sh
