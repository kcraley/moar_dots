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

    # Remove profile symlinks that point to our install staging directory.
    # Symlinks pointing elsewhere are left untouched to avoid disrupting
    # unrelated configuration.
    for entry in "${DOTFILES[@]}"; do
        local dest_template="${entry#*:}"
        local dest
        dest="$(eval echo "$dest_template")"
        dest="${dest%/}"

        if [[ -L "${dest}" ]]; then
            local link_target
            link_target="$(readlink "${dest}")"
            if [[ "${link_target}" == "${DOTS_INSTALL_DIR}"* ]]; then
                action "Removing symlink: ${dest}"
                rm "${dest}"
            else
                warn "Symlink at ${dest} does not point to install dir, skipping"
            fi
        elif [[ -e "${dest}" ]]; then
            warn "Not a managed symlink: ${dest}, skipping"
        else
            running "Not present: ${dest}\n"
        fi
    done

    # Remove the install staging directory.
    if [[ -d "${DOTS_INSTALL_DIR}" ]]; then
        action "Removing install directory: ${DOTS_INSTALL_DIR}"
        rm -rf "${DOTS_INSTALL_DIR}"
    fi

    ok "moar_dots uninstalled. Backups are preserved at: ${DOTS_BACKUP_DIR}"

    # Offer to restore original dotfiles from a backup so the user is left
    # in a consistent state rather than with empty profile destinations.
    if [[ -d "${DOTS_BACKUP_DIR}" ]]; then
        prompt "Restore original dotfiles from a backup now? [y|n]: " && read restore_response
        if [[ $restore_response =~ (yes|y|Y) ]]; then
            restore
        else
            warn "No backup restored. Profile destinations that were symlinked are now absent."
        fi
    fi
}
