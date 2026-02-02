#!/usr/bin/env bash
# Requirements for setting up dotfiles

# Mapping of dotfile sources (repo-relative) to destination path templates.
# Destinations use ${HOME} or ${XDG_CONFIG_HOME}; expanded at install time.
# Format: "source:dest_template" per entry.
DOTFILES=(
	".ackrc:\${HOME}/.ackrc"
	".aliasrc:\${HOME}/.aliasrc"
	".config/ghostty:\${XDG_CONFIG_HOME}/ghostty"
	".config/hypr:\${XDG_CONFIG_HOME}/hypr"
	".config/nvim:\${XDG_CONFIG_HOME}/nvim"
	".config/waybar:\${XDG_CONFIG_HOME}/waybar"
	".editorconfig:\${HOME}/.editorconfig"
	".zshrc:\${HOME}/.zshrc"
)

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
