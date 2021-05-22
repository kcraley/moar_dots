#!/bin/bash
# moar_dotz.sh - This is the main entrypoint for managing
# all dotfile and custom environment configuration.

# Global variables
export PROGRAM=$(basename "$0")
export COMMAND=$1
export BACKUPDIR="~/.dotfiles.bak"
export LIBRARY_DIR="$(pwd)/lib"

export VIM_AUTOLOAD_DIR=${VIM_AUTOLOAD_DIR:=${HOME}/.vim/autoload}
export VIM_PACKAGE_DIR=${VIM_PACKAGE_DIR:=${HOME}/vim/pack}

# Include lib helpers
for FILE in $(find ${LIBRARY_DIR} -type f); do
	source "${FILE}"
done

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
    
    # Configure and install all vim plugins
    if [[ -d ${VIM_AUTOLOAD_DIR} ]]; then
	action "Creating directory: ${VIM_AUTOLOAD_DIR}"
        mkdir -p ${VIM_AUTOLOAD_DIR}
    fi
    
    for DIR in $(readlink -f $0)/vim/pack/*; do
        if [[ -d ${DIR} ]]; then
            action "Linking vim plugin: $(basename ${DIR})"
	    ln -s -f "${DIR}" "${VIM_PACKAGE_DIR}/$(basename ${DIR})}"
	fi
    done

}

# Display splash screen
splash

# Read command line arguements
case "${COMMAND}" in
    -i|--install)
        # Run install
        install
        ;;
    -r|--restore)
        # Run install
        restore
        ;;
    -u|--uninstall)
        # Run install
        uninstall
        ;;
    -h|--help)
        printusage
        ;;
    '')
        error "Please select a command..." >&2
        printusage
        exit 1
        ;;
    *)
        error "Command not found..." >&2
        printusage
        exit 1
        ;;
esac
