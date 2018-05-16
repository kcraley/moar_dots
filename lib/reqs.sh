#!/usr/bin/env bash
# Requirements for setting up dotfiles

function require_node() {
    running "node -v"
    node -v
    if [ $? != 0 ]; then
        action "Node not found, install via package manager"
        curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
        sudo apt-get install -y nodejs
    fi
}
