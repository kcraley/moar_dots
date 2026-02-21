#!/usr/bin/env bash
# This script restores dotfiles from an existing backup.

# Usage: restore [backup-path]
#   backup-path  Optional path to a .tar.gz backup created by --backup.
#                When omitted, available backups are listed and the user is
#                prompted to select one interactively.
function restore() {
    local backup_file="${1:-}"

    # If no backup was specified, list available backups and prompt for one.
    if [[ -z "${backup_file}" ]]; then
        if [[ ! -d "${DOTS_BACKUP_DIR}" ]]; then
            error "No backup directory found at ${DOTS_BACKUP_DIR}"
            return 1
        fi

        local backups=()
        while IFS= read -r -d '' f; do
            backups+=("$f")
        done < <(find "${DOTS_BACKUP_DIR}" -maxdepth 1 -name "*.tar.gz" -print0 | sort -z)

        if [[ ${#backups[@]} -eq 0 ]]; then
            error "No backups found in ${DOTS_BACKUP_DIR}"
            return 1
        fi

        action "Available backups"
        local i=1
        for b in "${backups[@]}"; do
            running "${i}) $(basename "$b")\n"
            (( i++ ))
        done

        prompt "Select a backup [1-${#backups[@]}]: " && read selection
        if ! [[ "${selection}" =~ ^[0-9]+$ ]] || (( selection < 1 || selection > ${#backups[@]} )); then
            error "Invalid selection: ${selection}"
            return 1
        fi

        backup_file="${backups[$((selection - 1))]}"
    fi

    if [[ ! -f "${backup_file}" ]]; then
        error "Backup file not found: ${backup_file}"
        return 1
    fi

    action "Restoring from backup: $(basename "${backup_file}")"
    prompt "This will overwrite existing dotfiles at their profile locations. Continue? [y|n]: " && read response
    if [[ ! $response =~ (yes|y|Y) ]]; then
        action "Aborting restore..."
        return 0
    fi

    # Remove any managed symlinks so the extracted files land as real files.
    for entry in "${DOTFILES[@]}"; do
        local dest_template="${entry#*:}"
        local dest
        dest="$(eval echo "$dest_template")"
        dest="${dest%/}"

        if [[ -L "${dest}" ]]; then
            action "Removing symlink: ${dest}"
            rm "${dest}"
        fi
    done

    # Extract the backup archive relative to $HOME (archive paths are relative
    # to $HOME, matching how they were created by --backup).
    if tar -xzf "${backup_file}" -C "${HOME}"; then
        ok "Restore complete from: $(basename "${backup_file}")"
    else
        error "Restore failed"
        return 1
    fi
}
