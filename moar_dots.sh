#!/bin/bash
# moar_dotz.sh - This is the main entrypoint for managing
# all dotfile and custom environment configuration.

# Global variables
export PROGRAM=$(basename "$0")
export COMMAND=$1
export BACKUPDIR="~/.dotfiles.bak"
export LIBRARY_DIR="$(pwd)/lib"

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=~/.config}
export XDG_STATE_HOME=${XDG_STATE_HOME:=~/.local/state}
export XDG_DATA_HOME=${XDG_DATA_HOME:=~/.local/share}

export HOME_BIN_DIR=${HOME_BIN_DIR:=~/bin}
export HOME_ENV_DIR=${HOME_ENV_DIR:=~/.env}

export TFENV_DIR=${TFENV_DIR:=~/.tfenv}
export FZF_DIR=${FZF_DIR:=~/.fzf}
export SYSTEMD_USER_DIR=${SYSTEMD_USER_DIR:=${XDG_CONFIG_HOME}/systemd/user}

# Include lib helpers
for FILE in $(find ${LIBRARY_DIR} -type f); do
	source "${FILE}"
done

# Display splash screen
splash

# Read command line arguements
case "${COMMAND}" in
    -b|--backup)
        backup
        ;;
    -i|--install)
        install
        ;;
    -r|--restore)
        restore
        ;;
    -u|--uninstall)
        uninstall
        ;;
    -h|--help)
        printusage
        ;;
    '')
        error "Please select a command. Please use -h or --help to see the available commands." >&2
        exit 1
        ;;
    *)
        error "Command not found. Please use -h or --help to see the available commands." >&2
        exit 1
        ;;
esac
