#!/bin/bash
# moar_dotz.sh - This is the main entrypoint for managing
# all dotfile and custom environment configuration.

# Global variables
export PROGRAM=$(basename "$0")
export COMMAND=$1
export BACKUPDIR="~/.dotfiles.bak"
export LIBRARY_DIR="$(pwd)/lib"

export VIM_AUTOLOAD_DIR=${VIM_AUTOLOAD_DIR:=~/.vim/autoload}
export VIM_BUNDLE_DIR=${VIM_BUNDLE_DIR:=~/.vim/bundle}

# Include lib helpers
for FILE in $(find ${LIBRARY_DIR} -type f); do
	source "${FILE}"
done

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
