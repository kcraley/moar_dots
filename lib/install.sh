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
    
    # Initialize Git submodules
    action "Initializing Git submodules"
    git submodule update --init --recursive
    
    # Create necessary Vim directories
    if [[ ! -d ${VIM_AUTOLOAD_DIR} ]]; then
	action "Creating directory: ${VIM_AUTOLOAD_DIR}"
        mkdir -p ${VIM_AUTOLOAD_DIR}
    fi
    if [[ ! -d ${VIM_BUNDLE_DIR} ]]; then
        action "Creating directory: ${VIM_BUNDLE_DIR}"
	mkdir -p ${VIM_BUNDLE_DIR}
    fi
   
    # Install Vim Pathogen
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

    # Link all Vim Plugins
    for DIR in $(pwd)/vim/pack/*; do
        if [[ -d ${DIR} ]]; then
            action "Linking vim plugin: $(basename ${DIR})"
	    ln -s -f "${DIR}" "${VIM_BUNDLE_DIR}/$(basename ${DIR})"
	fi
    done

    # Install Vim configuration
    action "Installing custom ~/.vimrc"
    ln -s -f "$(pwd)/vim/.vimrc" "${HOME}/.vimrc"
}

