#!/usr/bin/env bash

# This script contains all logic to install moar dots
# and the associated configuration files.

# This is the main install function which is called
# when `./moar_dots -i` is executed.
#
# Each profile destination becomes a symlink directly into this repository, so
# edits made to live files land in the git working tree. Anything that would be
# replaced is captured in a backup first.
function install() {
    # Work out what would be replaced so it can be shown before confirming.
    local to_replace=()
    for entry in "${DOTFILES[@]}"; do
        local src="${entry%%:*}"
        local dest
        dest="$(dotfile_dest "${entry}")"

        if [[ -e "${dest}" ]] && ! is_linked "${dest}" "${REPO_DIR}/${src}"; then
            to_replace+=( "${dest}" )
        fi
    done

    action "We are going to install the dotfiles from moar_dots"
    if [[ ${#to_replace[@]} -gt 0 ]]; then
        warn "These will be backed up and then replaced with symlinks:"
        for dest in "${to_replace[@]}"; do
            running "${dest}\n"
        done
    fi

    prompt "Would you like to continue? [y|n]: " && read response
    if [[ $response =~ ^(y|Y|yes)$ ]]; then
        action "Let's get started!"
    else
        action "Aborting installation..."
        exit 0
    fi

    action "Beginning installation"

    # Never remove anything until a backup of it exists.
    if [[ ${#to_replace[@]} -gt 0 ]]; then
        if ! backup; then
            error "Backup failed, nothing was changed. Aborting installation."
            exit 1
        fi
    fi

    # Create XDG Base directories
    create_dir "${XDG_CONFIG_HOME}"
    create_dir "${XDG_DATA_HOME}"
    create_dir "${XDG_STATE_HOME}"

    # Create custom home directories
    create_dir "${HOME_BIN_DIR}"
    create_dir "${HOME_ENV_DIR}"
    if [[ -d "${HOME_ENV_DIR}" ]]; then
        touch -a "${HOME_ENV_DIR}/secrets"
    fi

    for entry in "${DOTFILES[@]}"; do
        local src="${entry%%:*}"
        local src_path="${REPO_DIR}/${src}"
        local dest
        dest="$(dotfile_dest "${entry}")"

        if [[ ! -e "${src_path}" ]]; then
            warn "Source not found, skipping: ${src_path}"
            continue
        fi

        # Checked by resolved path so a destination that already reaches the
        # repository is never removed.
        if is_linked "${dest}" "${src_path}"; then
            running "Already linked: ${dest}\n"
            continue
        fi

        rm -rf -- "${dest}"
        link "${src_path}" "${dest}"
    done

    ok "Installation complete"
}
