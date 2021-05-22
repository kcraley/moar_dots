#!/usr/bin/env bash
# This is a collection of utility functions that
# are resused across moar dots actions.

# Load printers
source ./printers.sh

function create_dir() {
    if [[ ! -d "$1" ]]; then
	action "Creating directory: $1"
	mkdir -p "$1"
    else
	warn "Skipping directory creation, already exists: $1"
    fi
}

function link() {
    action "Linking file: $1 -> $2"
    ln -s -f "$1" "$2"
}

