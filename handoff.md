# Handoff

## 1. Goals
One terminal command sets up your brother's Intel iMac on macOS 10.13. The command installs a package manager, the terminal tools, your sanitized dotfiles, Minecraft, Roblox, Discord and Zoom.

## 2. Current state
- The repo is pushed to the private repo `ADM1SH/brother-dotfiles`.
- The install uses MacPorts, not Homebrew.
- The install has not been tested on the iMac yet.

## 3. Active files
- `install.sh`
- `zshrc`
- `tmux.conf`
- `starship.toml`
- `nvim/`

## 4. Changes made
- `zshrc` comes from your `.zshrc`, with these changes:
  - API keys removed.
  - Personal aliases and PATH lines removed.
  - The PATH points to MacPorts (`/opt/local`).
- `install.sh` does these steps:
  1. Makes sure that the Command Line Tools are installed.
  2. Installs MacPorts 2.12.6, the High Sierra build.
  3. Installs 12 ports.
  4. Installs Minecraft and Discord from their DMG files, Zoom from its pkg, and Roblox from its zip.
  5. Installs the JetBrains Mono Nerd Font.
  6. Copies in the dotfiles, after a backup of the old files.
  7. Installs TPM.
  8. Sets the MacPorts zsh as the login shell.
  9. Prints a summary. The summary names each app whose LSMinimumSystemVersion is newer than 10.13.

## 5. Failed attempts
- The first version used Homebrew. It failed on the iMac with "Homebrew on macOS is only supported on Apple Silicon processors!".
  - The Homebrew installer removed Intel macOS support on 2026-09-11 (commit e078684c4a in Homebrew/install).
  - Separately, brew sets `HOMEBREW_MACOS_OLDEST_ALLOWED="11"`, so it refuses macOS 10.13.
- lazygit is not in the port list because its MacPorts build fails on 10.13 (status "failed install-port").

## 6. Next steps
1. Run the one-liner on the iMac.
2. If the Command Line Tools popup shows, finish that install, then run the one-liner again.
3. Read the summary for failed installs and for apps that need a newer macOS.
