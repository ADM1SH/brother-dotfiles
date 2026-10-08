#!/bin/bash
# Setup for an Intel Mac on macOS 10.13 with MacPorts. Each install continues on failure. A summary prints at the end.
set -u
DIR="$(cd "$(dirname "$0")" && pwd)"
TMP="$(mktemp -d)"
MACOS="$(sw_vers -productVersion)"
ok=() fail=() warn=()

if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install
  echo "Finish the Command Line Tools install in the popup. Then run this script again."
  exit 1
fi

sudo -v

if [[ ! -x /opt/local/bin/port ]]; then
  curl -fL -o "$TMP/MacPorts.pkg" https://github.com/macports/macports-base/releases/download/v2.12.6/MacPorts-2.12.6-10.13-HighSierra.pkg
  sudo installer -pkg "$TMP/MacPorts.pkg" -target / || { echo "MacPorts install failed. Stopping."; exit 1; }
fi
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
sudo port -N selfupdate

# ponytail: lazygit is not in the list because its MacPorts build fails on 10.13
for p in git zsh tmux neovim starship eza bat fzf fd ripgrep zoxide direnv; do
  if sudo port -N install "$p"; then ok+=("$p"); else fail+=("$p"); fi
done

# Check that an installed app supports this macOS, from LSMinimumSystemVersion in its Info.plist
check_min() {
  local min
  min="$(defaults read "$1/Contents/Info" LSMinimumSystemVersion 2>/dev/null)" || return 0
  zsh -c "autoload is-at-least; is-at-least $min $MACOS" || warn+=("$(basename "$1") needs macOS $min+")
}

install_dmg() { # name url
  local mnt="$TMP/mnt-$1" app
  curl -fL --connect-timeout 30 -o "$TMP/$1.dmg" "$2" && hdiutil attach -nobrowse -quiet -mountpoint "$mnt" "$TMP/$1.dmg" || return 1
  app="$(find "$mnt" -maxdepth 1 -name '*.app' | head -1)"
  if [[ -n "$app" ]]; then
    sudo cp -R "$app" /Applications/
  else
    app="$(find "$mnt" -maxdepth 1 -name '*.pkg' | head -1)"
    [[ -n "$app" ]] && sudo installer -pkg "$app" -target /
  fi
  local rc=$?
  hdiutil detach -quiet "$mnt"
  [[ $rc -eq 0 && "$app" == *.app ]] && check_min "/Applications/$(basename "$app")"
  return $rc
}

if install_dmg Minecraft https://launcher.mojang.com/download/Minecraft.dmg; then ok+=(minecraft); else fail+=(minecraft); fi
if install_dmg Discord "https://discord.com/api/download?platform=osx"; then ok+=(discord); else fail+=(discord); fi
# ponytail: Firefox ESR 115 is the last Firefox branch for macOS 10.12-10.14
if install_dmg Firefox "https://download.mozilla.org/?product=firefox-esr115-latest-ssl&os=osx&lang=en-US"; then ok+=(firefox-esr115); else fail+=(firefox-esr115); fi
if install_dmg VLC https://get.videolan.org/vlc/3.0.24/macosx/vlc-3.0.24-intel64.dmg; then ok+=(vlc); else fail+=(vlc); fi
if install_dmg XScreenSaver https://www.jwz.org/xscreensaver/xscreensaver-6.16.dmg; then ok+=(xscreensaver); else fail+=(xscreensaver); fi

if curl -fL -o "$TMP/Zoom.pkg" https://zoom.us/client/latest/Zoom.pkg && sudo installer -pkg "$TMP/Zoom.pkg" -target /; then
  ok+=(zoom); check_min /Applications/zoom.us.app
else fail+=(zoom); fi

rbx="$(curl -fsSL https://clientsettingscdn.roblox.com/v2/client-version/MacPlayer | sed -n 's/.*"clientVersionUpload":"\([^"]*\)".*/\1/p')"
if [[ -n "$rbx" ]] && curl -fL -o "$TMP/Roblox.zip" "https://setup.rbxcdn.com/mac/$rbx-RobloxPlayer.zip" && sudo ditto -x -k "$TMP/Roblox.zip" /Applications; then
  ok+=(roblox); check_min /Applications/RobloxPlayer.app
else fail+=(roblox); fi

if curl -fL -o "$TMP/font.zip" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip && unzip -o -q "$TMP/font.zip" '*.ttf' -d ~/Library/Fonts; then
  ok+=(jetbrains-mono-nerd-font)
else fail+=(jetbrains-mono-nerd-font); fi

backup() { [[ -e "$1" ]] && mv "$1" "$1.bak.$(date +%s)"; }
backup ~/.zshrc;          cp "$DIR/zshrc" ~/.zshrc
backup ~/.tmux.conf;      cp "$DIR/tmux.conf" ~/.tmux.conf
mkdir -p ~/.config
backup ~/.config/starship.toml; cp "$DIR/starship.toml" ~/.config/starship.toml
backup ~/.config/nvim;    cp -R "$DIR/nvim" ~/.config/nvim

[[ -d ~/.tmux/plugins/tpm ]] || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# The zinit plugins need a newer zsh than the 10.13 system zsh, so use the MacPorts zsh as the login shell
if [[ -x /opt/local/bin/zsh ]]; then
  grep -qx /opt/local/bin/zsh /etc/shells || echo /opt/local/bin/zsh | sudo tee -a /etc/shells >/dev/null
  chsh -s /opt/local/bin/zsh
fi

rm -rf "$TMP"
echo
echo "===== SUMMARY ====="
echo "Installed: ${ok[*]:-none}"
echo "Failed:    ${fail[*]:-none}"
[[ ${#warn[@]} -gt 0 ]] && printf 'Will not open on macOS %s: %s\n' "$MACOS" "${warn[@]}"
echo "Skipped:   helium-browser (needs macOS 13+), whatsapp (12+), vorssaint (14+), ghostty (13+)"
echo "Open a new terminal. In tmux, press Ctrl+Space then I to install the tmux plugins."
