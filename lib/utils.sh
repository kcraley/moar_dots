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

#
# Convert an absolute file path to a path relative to a base directory.
# Usage: to_relative_path [base] [absolute-path]
# Examples:
#   to_relative_path "/home/user" "/home/user/.config/nvim" -> ".config/nvim"
#   to_relative_path "/home/user" "/home/user" -> "."
#   to_relative_path "/home/user" "/etc/hosts" -> "/etc/hosts" (unchanged)
#
function to_relative_path() {
    local base="${1:-$HOME}"
    local path="${2:-}"

    if [[ -z "$path" ]]; then
        return 1
    fi

    if [[ "$path" == "$base" ]]; then
        printf '.'
    elif [[ "$path" == "$base/"* ]]; then
        printf '%s' "${path#$base/}"
    else
        printf '%s' "$path"
    fi
}

