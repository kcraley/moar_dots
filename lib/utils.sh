#!/usr/bin/env bash
# This is a collection of utility functions that
# are resused across moar dots actions.

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
# Expand a DOTFILES entry into its profile destination path.
# Usage: dotfile_dest [entry]
# Example:
#   dotfile_dest ".config/nvim:\${XDG_CONFIG_HOME}/nvim/" -> "/home/user/.config/nvim"
#
function dotfile_dest() {
    local dest
    dest="$(eval echo "${1#*:}")"
    # Strip the trailing slash so paths refer to a symlink, not inside it
    printf '%s' "${dest%/}"
}

#
# Check whether a profile destination resolves to a path in this repository.
# Usage: is_linked [dest] [src-path]
#
function is_linked() {
    [[ "$(readlink -f "$1")" == "$2" ]]
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

