#!/usr/bin/env bash

# This script contains all logic to install moar dots
# and the associated configuration files.

# This is the main install function which is called
# when `./moar_dots.sh -i` is executed.
function install() {
    local repo_dir="$(pwd)"

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
    create_dir "${XDG_CONFIG_HOME}"
    create_dir "${XDG_DATA_HOME}"
    create_dir "${XDG_STATE_HOME}"

    # Create custom home directories
    create_dir "${HOME_BIN_DIR}"
    create_dir "${HOME_ENV_DIR}"
    if [[ -d "${HOME_ENV_DIR}" ]]; then
        touch -a "${HOME_ENV_DIR}/secrets"
    fi

    # Create the install staging directory where repo dotfiles are copied.
    # Profile symlinks point here so the underlying files can be swapped
    # without touching the repo or the user's profile paths directly.
    create_dir "${DOTS_INSTALL_DIR}"

    for entry in "${DOTFILES[@]}"; do
        local src="${entry%%:*}"
        local dest_template="${entry#*:}"
        local dest
        dest="$(eval echo "$dest_template")"
        # Strip trailing slash so ln -s targets the path, not inside it
        dest="${dest%/}"

        local src_path="${repo_dir}/${src}"
        local install_path="${DOTS_INSTALL_DIR}/${src}"

        if [[ ! -e "${src_path}" ]]; then
            warn "Source not found, skipping: ${src_path}"
            continue
        fi

        # Ensure intermediate directories exist inside the install dir
        mkdir -p "$(dirname "${install_path}")"

        # Copy the source into the install staging directory.
        # Use the contents form (src/.) for directories to avoid double-nesting
        # when the target already exists.
        if [[ -d "${src_path}" ]]; then
            running "Staging directory: ${src} -> ${install_path}\n"
            mkdir -p "${install_path}"
            cp -rf "${src_path}/." "${install_path}/"
        else
            running "Staging file: ${src} -> ${install_path}\n"
            cp -f "${src_path}" "${install_path}"
        fi

        # If dest already exists as a real (non-symlink) directory we cannot
        # atomically replace it with a symlink—warn and skip.
        if [[ -d "${dest}" && ! -L "${dest}" ]]; then
            warn "Real directory exists at ${dest}. Run --backup first, then remove it manually."
            continue
        fi

        # Remove a stale symlink so ln -s can place the new one cleanly.
        if [[ -L "${dest}" ]]; then
            rm "${dest}"
        fi

        link "${install_path}" "${dest}"
    done

    ok "Installation complete"
}
