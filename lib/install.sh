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

    # Install tfenv
    create_dir ${TFENV_DIR}
    if [[ ! -d ${TFENV_DIR}/.git ]]; then
        action "Cloning tfenv repository"
        git clone https://github.com/tfutils.tfenv.git ${TFENV_DIR}
    else
        warn "Skipping Git clone, tfenv may already be installed"
    fi

    # Install fzf
    create_dir ${FZF_DIR}
    if [[ ! -d ${FZF_DIR}/.git ]];then
        action "Cloning fzf repository"
        git clone https://github.com/junegunn/fzf.git ${FZF_DIR}
    else
        warn "Skipping Git clone, fzf may already be installed"
    fi
    if [[ -f ${FZF_DIR}/install ]]; then
        action "Installing fzf"
        ${FZF_DIR}/install --all
    fi

    # Install imwheel
    create_dir ${SYSTEMD_USER_DIR}
    link "$(pwd)/systemd/user/imwheel.service" "${SYSTEMD_USER_DIR}/imwheel.service"

    # Install custom rc files
    link "$(pwd)/.ackrc" "${HOME}/.ackrc"
    link "$(pwd)/.aliasrc" "${HOME}/.aliasrc"
    link "$(pwd)/.config/nvim" "${XDG_CONFIG_HOME}/nvim"
    link "$(pwd)/.editorconfig" "${HOME}/.editorconfig"
    link "$(pwd)/.imwheelrc" "${HOME}/.imwheelrc"
    link "$(pwd)/.zshrc" "${HOME}/.zshrc"
}

