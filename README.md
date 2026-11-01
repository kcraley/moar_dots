![MOAR DOTS!](./img/dots.png)

# MOAR DOTS!
Which do you see, 21 or 74? Be care, the devil is in the details!

## Contents
  * [About](#About)
  * [Usage](#Usage)
  * [Backup](#Backup)
  * [Install](#Install)
  * [Restore](#Restore)
  * [Uninstall](#Uninstall)
  * [Disclaimer](#Disclaimer)

## About
Your dot files speak volume and are a general reflection of one's personality. Some can be colorful and eccentric while others dull and plain. These are my custom dotfiles.

## Usage

Run `moar_dots` with one of the subcommand flags below. It can be run from any directory. Pass `-h` or `--help` to see all available options at any time.

```text
 .::       .::                                .:::::                .::
 .: .::   .:::                                .::   .::             .::
 .:: .:: . .::   .::       .::    .: .:::     .::    .::   .::    .:.: .: .:::: 
 .::  .::  .:: .::  .::  .::  .::  .::        .::    .:: .::  .::   .::  .::    
 .::   .:  .::.::    .::.::   .::  .::        .::    .::.::    .::  .::    .::: 
 .::       .:: .::  .:: .::   .::  .::        .::   .::  .::  .::   .::      .::
 .::       .::   .::      .:: .:::.:::        .:::::       .::       .:: .:: .::

Usage: moar_dots [-option]

Options:
-b  --backup         Create a backup of current dotfiles
-h  --help           Print this help message
-i  --install        Install the new configuration of dotfiles
-r  --restore [path] Restore dotfiles from a backup (interactive if path omitted)
-u  --uninstall      Uninstall an existing version of moar_dots
```

For a fresh setup, run **install**, which backs up anything it replaces. To revert: **uninstall** (which offers an integrated restore step), or run **restore** independently at any time.

## Backup

The backup command snapshots the dotfiles currently active in your profile and saves them as a compressed tarball in `~/.config/dots/backup/`. Each archive is named with a timestamp (`YYYYMMDD-HH:MM:SS.tar.gz`) so multiple backups can coexist without overwriting one another. Archives hold real file contents, so a backup can be taken at any time and still restores correctly after an uninstall.

```sh
./moar_dots --backup
```

## Install

The install command creates symlinks from the expected profile locations (e.g. `~/.zshrc`, `~/.config/nvim/`) directly into this repository. Edits to live files therefore land in the git working tree, ready to review with `git diff` and commit. Because the links are absolute, reinstall after moving the repository.

Before anything is changed, install lists the existing files and directories it will replace. It then saves them in a backup, and aborts without changing anything if that backup fails. Destinations that are already linked are left alone, so install is safe to re-run.

```sh
./moar_dots --install
```

## Restore

The restore command extracts a previously created backup archive back to its original profile locations, returning the system to the state captured at backup time. A specific backup can be provided directly as an argument; when omitted, restore lists all available backups interactively and prompts for a selection. Before extracting, any managed symlinks at the destination paths are removed so the restored files land as regular files rather than broken links.

```sh
# Interactive selection
./moar_dots --restore

# Point at a specific backup
./moar_dots --restore ~/.config/dots/backup/20250101-09:00:00.tar.gz
```

## Uninstall

The uninstall command removes all symlinks from the user profile that point into this repository. Only symlinks that were created by moar_dots are touched — anything pointing elsewhere is left intact. Backups in `~/.config/dots/backup/` are never removed. After the cleanup, uninstall offers to run restore interactively so the user's original dotfiles can be returned to their profile in the same operation.

```sh
./moar_dots --uninstall
```

## Disclaimer
> Warning: The creator of this repo is not responsible for any unwanted changes that this makes to your machine. If you are concerned at what chances will be made, please review all code before hand. Thanks!
