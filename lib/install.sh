#!/usr/bin/env bash

# This script contains all logic to install moar dots
# and the associated configuration files.

# This is the main install function which is called
# when `./moar_dots.sh -i` is executed.
function install() {
    action "We are going to install the dotfiles from moar_dotz"
    prompt "Would you like to continue? [y|n]: " && read response
    if [[ $response =~ (yes|y|Y) ]]; then
        action "Let's get started!"
    else
        action "Aborting installation..."
        exit 0
    fi

    action "Beginning installation"

    # Create XDG Base directories
    create_dir ${XDG_CONFIG_HOME}
    create_dir ${XDG_DATA_HOME}
    create_dir ${XDG_STATE_HOME}

    # Initialize Git submodules
    action "Initializing Git submodules"
    git submodule update --init --recursive

    # Create custom home directories
    create_dir "${HOME_BIN_DIR}"
    create_dir "${HOME_ENV_DIR}"
    if [[ -f "${HOME_ENV_DIR}" ]]; then
        touch -a "${HOME_ENV_DIR}/secrets"
    fi

    # Install dotfiles from mapping (lib/reqs.sh DOTFILES).
    for entry in "${DOTFILES[@]}"; do
        src="${entry%%:*}"
        dest_template="${entry#*:}"
        dest="$(eval echo "$dest_template")"
        if [[ -e "$(pwd)/${src}" ]]; then
            link "$(pwd)/${src}" "${dest}"
        fi
    done
}

