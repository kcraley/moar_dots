#!/bin/bash
# This script installs the dotfiles and runs other configuration

# Include lib helpers
source ./lib/printers.sh
source ./lib/reqs.sh

# Set global variables
backupdir=~/.dotfile.backups
CMD="$1"
dotfiles=$(pwd)
program=$(basename "$0")

function install() {
    action "We are going to install the dotfiles from moar_dotz"
    prompt "Would you like to continue? [y|n]: " && read response
    if [[ $response =~ (yes|y|Y) ]]; then
        action "Let's get started!"
    else
        exit 0
    fi
}

# Read command line arguements
case "$CMD" in
    -i|--install)
        # Display splash
        splash
        # Run install
        install
        ;;
    -r|--restore)
        # Display splash
        splash
        # Run install
        restore
        ;;
    -u|--uninstall)
        # Display splash
        splash
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
