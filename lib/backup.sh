#!/usr/bin/env bash
# This script creates a backup of the existing dotfiles.

# Archives the real contents of each profile destination. A destination that is
# a symlink is resolved first, since an archived link would dangle once its
# target is gone. Symlinks nested inside a directory are preserved as they are.
function backup() {
    local timestamp="$(date +%Y%m%d-%H:%M:%S)"
    local backup_path="${DOTS_BACKUP_DIR}/${timestamp}.tar.gz"
    local files_to_backup=()

    create_dir "${DOTS_BACKUP_DIR}"

    for entry in "${DOTFILES[@]}"; do
        local dest
        dest="$(dotfile_dest "${entry}")"
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

    # Build the snapshot in a temporary directory, laid out relative to $HOME
    # so the archive doesn't contain absolute paths.
    local snapshot
    if ! snapshot="$(mktemp -d)"; then
        error "Failed to create a temporary directory"
        return 1
    fi

    local rel_files=()
    for f in "${files_to_backup[@]}"; do
        local rel
        rel="$(to_relative_path "$HOME" "$f")"
        mkdir -p "${snapshot}/$(dirname "$rel")"
        if ! cp -a "$(readlink -f "$f")" "${snapshot}/${rel}"; then
            error "Failed to copy ${f}"
            rm -rf "${snapshot}"
            return 1
        fi
        rel_files+=( "$rel" )
    done

    # --force-local stops tar treating the colons in the timestamp as a remote
    # host. The archive is read back because install deletes files after this.
    if tar --force-local -czf "${backup_path}" -C "${snapshot}" "${rel_files[@]}" \
        && tar --force-local -tzf "${backup_path}" > /dev/null; then
        ok "Backup complete: ${backup_path}"
        rm -rf "${snapshot}"
    else
        error "Backup failed"
        rm -rf "${snapshot}"
        return 1
    fi
}
