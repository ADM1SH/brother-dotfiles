# Handoff

## 1. Goals
One terminal command sets up your brother's Intel iMac on macOS 10.13. The command installs Homebrew, the terminal tools, your sanitized dotfiles, Minecraft, Roblox, Discord and Zoom.

## 2. Current state
- The repo is built locally in `~/brother-dotfiles`.
- The repo is not pushed yet.
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
  - The `/opt/homebrew` LLVM block removed.
  - Personal aliases and PATH lines removed.
  - The brew path is detected for Intel and for Apple Silicon.
- `install.sh` does these steps:
  - Installs brew.
  - Installs 13 formulae and 5 casks. Each install continues on failure.
  - Skips helium, whatsapp, vorssaint and ghostty, which need macOS 12 or later.
  - Backs up the old dotfiles and copies in the new ones.
  - Installs TPM.
  - Runs `chsh`.
  - Prints a summary.

## 5. Failed attempts
None. shellcheck is not installed on this MBP, so the shellcheck step did not run. `bash -n` and `zsh -n` passed.

## 6. Next steps
1. Push the repo: `gh repo create brother-dotfiles --private --source . --push`.
2. Run the one-liner on the iMac.
3. Read the printed summary for failed installs. Neovim and lazygit are the most likely to fail when they build from source.
