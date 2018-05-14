#!/bin/bash
# This script installs the dotfiles and runs other configuration

# Include lib helpers
source ./lib/printers.sh
source ./lib/reqs.sh

# Set global variables
CMD="$1"
dotfiles=$(pwd)
program=$(basename "$0")

#
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
