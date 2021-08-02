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
    
    # Create custom home directories
    create_dir "${HOME_BIN_DIR}"
    create_dir "${HOME_ENV_DIR}"
    if [[ -f "${HOME_ENV_DIR}" ]]; then
        touch -a "${HOME_ENV_DIR}/secrets"
    fi

    # Create Vim directories
    create_dir ${VIM_AUTOLOAD_DIR}
    create_dir ${VIM_BUNDLE_DIR}
   
    # Install Vim Pathogen
    if [[ ! -f ${VIM_AUTOLOAD_DIR}/pathogen.vim ]]; then
        action "Downloading and installing Vim Pathogen"
        curl -LSso "${VIM_AUTOLOAD_DIR}/pathogen.vim" https://tpo.pe/pathogen.vim
    else
        warn "Skipping Vim Pathogen installation, already exists: ${VIM_AUTOLOAD_DIR}/pathogen.vim"
    fi

    # Link all Vim Plugins
    for DIR in $(pwd)/vim/pack/*; do
        if [[ -d ${DIR} ]]; then
            link "${DIR}" "${VIM_BUNDLE_DIR}/$(basename ${DIR})"
        fi
    done

    # Install Vim configuration
    link "$(pwd)/vim/.vimrc" "${HOME}/.vimrc"

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
    link "$(pwd)/.imwheelrc" "${HOME}/.imwheelrc"
    link "$(pwd)/.zshrc" "${HOME}/.zshrc"
}

