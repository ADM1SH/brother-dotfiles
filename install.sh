#!/bin/bash
# Setup for an Intel Mac on macOS 10.13. Each install continues on failure. A summary prints at the end.
set -u
DIR="$(cd "$(dirname "$0")" && pwd)"
ok=() fail=() skip=()

if ! command -v brew >/dev/null && [[ ! -x /usr/local/bin/brew && ! -x /opt/homebrew/bin/brew ]]; then
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
for b in /opt/homebrew/bin/brew /usr/local/bin/brew; do [[ -x "$b" ]] && eval "$("$b" shellenv)" && break; done
command -v brew >/dev/null || { echo "Homebrew install failed. Stopping."; exit 1; }

for f in git zsh tmux neovim starship eza bat fzf fd zoxide lazygit ripgrep direnv; do
  if brew install "$f"; then ok+=("$f"); else fail+=("$f"); fi
done

for c in minecraft roblox discord zoom font-jetbrains-mono-nerd-font; do
  if brew install --cask "$c"; then ok+=("$c"); else fail+=("$c"); fi
done

# ponytail: these casks require a newer macOS than 10.13 (from the brew cask metadata), so the script does not try them
skip=("helium-browser (needs macOS 13+)" "whatsapp (needs macOS 12+)" "vorssaint (needs macOS 14+)" "ghostty (needs macOS 13+)")

backup() { [[ -e "$1" ]] && mv "$1" "$1.bak.$(date +%s)"; }
backup ~/.zshrc;          cp "$DIR/zshrc" ~/.zshrc
backup ~/.tmux.conf;      cp "$DIR/tmux.conf" ~/.tmux.conf
mkdir -p ~/.config
backup ~/.config/starship.toml; cp "$DIR/starship.toml" ~/.config/starship.toml
backup ~/.config/nvim;    cp -R "$DIR/nvim" ~/.config/nvim

[[ -d ~/.tmux/plugins/tpm ]] || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

[[ "$SHELL" == "/bin/zsh" ]] || chsh -s /bin/zsh

echo
echo "===== SUMMARY ====="
echo "Installed: ${ok[*]:-none}"
echo "Failed:    ${fail[*]:-none}"
printf 'Skipped:   %s\n' "${skip[@]}"
echo "Open a new terminal. In tmux, press Ctrl+Space then I to install the tmux plugins."
