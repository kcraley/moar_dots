#!/usr/bin/env bash
# Requirements for setting up dotfiles

function require_node() {
    running "node -v"
    node -v
    if [[ $? != 0 ]]; then
        warning "Node not found, install via package manager"
        running "curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -"
        curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
        running "sudo apt-get install -y nodejs"
        sudo apt-get install -y nodejs
    else
        running "Node is already installed"
        ok
    fi
}

function require_ohmyzsh() {
    running "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    if [[ $? != 0 ]]; then
        ok
    else
        error
        exit 1
    fi
}
