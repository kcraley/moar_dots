#!/usr/bin/env bash
# This script creates a backup of the existing dotfiles.

function backup() {
    local timestamp="$(date +%Y%m%d-%H:%M:%S)"
    local backup_path="${DOTS_BACKUP_DIR}/${timestamp}.tar.gz"
    local files_to_backup=()

    create_dir "${DOTS_BACKUP_DIR}"

    for entry in "${DOTFILES[@]}"; do
        dest_template="${entry#*:}"
        dest="$(eval echo "$dest_template")"
        if [[ -e "$dest" ]]; then
            running "$COL_LIGHT_GREEN[Location found]$COL_RESET\t\t${dest}\n"
            files_to_backup+=( "$dest" )
        else
            running "$COL_RED[Location not found]$COL_RESET\t${dest}\n"
        fi
    done

    if [[ ${#files_to_backup[@]} -eq 0 ]]; then
        warn "No dotfiles found to backup"
        return 1
    fi

    action "Creating backup at ${backup_path}"
    # Change into the user's home directory so tar paths are relative to $HOME
    if ! pushd "${HOME}" > /dev/null 2>&1; then
        error "Failed to change directory to ${HOME}"
        return 1
    fi

    # Convert absolute file paths to paths relative to $HOME when possible so the
    # archive doesn't contain absolute paths.
    local rel_files=()
    for f in "${files_to_backup[@]}"; do
        rel_files+=( "$(to_relative_path "$HOME" "$f")" )
    done

    if tar -czf "${backup_path}" "${rel_files[@]}"; then
        ok "Backup complete: ${backup_path}"
    else
        error "Backup failed"
        popd > /dev/null 2>&1
        return 1
    fi

    # Return to the original directory
    popd > /dev/null 2>&1
}
