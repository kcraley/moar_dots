#!/usr/bin/env bash
# This script reports how the live dotfiles compare to this repository.

# Read-only. Prints the state of every dotfile, then any repository changes
# that have not been committed or pushed.
function status() {
    for entry in "${DOTFILES[@]}"; do
        local src="${entry%%:*}"
        local src_path="${REPO_DIR}/${src}"
        local dest
        dest="$(dotfile_dest "${entry}")"

        if [[ ! -e "${src_path}" ]]; then
            running "$COL_RED[Not in repo]$COL_RESET\t\t${dest}\n"
        elif is_linked "${dest}" "${src_path}"; then
            running "$COL_LIGHT_GREEN[Linked]$COL_RESET\t\t${dest}\n"
        elif [[ -L "${dest}" ]]; then
            running "$COL_RED[Linked elsewhere]$COL_RESET\t${dest} -> $(readlink "${dest}")\n"
        elif [[ ! -e "${dest}" ]]; then
            running "$COL_LIGHT_YELLOW[Not installed]$COL_RESET\t${dest}\n"
        elif diff -rq "${dest}" "${src_path}" > /dev/null 2>&1; then
            running "$COL_LIGHT_YELLOW[Same as repo, unlinked]$COL_RESET\t${dest}\n"
        else
            running "$COL_RED[Differs from repo]$COL_RESET\t${dest}\n"
            diff -rq "${dest}" "${src_path}" 2>&1 | sed 's/^/      /'
        fi
    done

    echo
    action "Repository state"
    git -C "${REPO_DIR}" status --short --branch
}
