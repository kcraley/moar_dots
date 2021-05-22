#!/usr/bin/env bash

# This script contains all logic necessary to uninstall
# moar dots, all dotfiles and configurations made.

# This is the main uninstall function which is called
# when `./moar_dots.sh -u` is executed.
function uninstall() {
    action "We are going to uninstall the dotfiles from moar_dots"
    prompt "Would you like to continue? [y|n]: " && read response
    if [[ $response =~ (yes|y|Y) ]]; then
	action "Removing dotfiles and custom configuration!"
    else
	action "Aborting uninstallation"
	exit 0
    fi

    action "Beginning uninstall"
}
