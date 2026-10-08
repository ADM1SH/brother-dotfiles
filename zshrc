# MacPorts environment setup
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export MANPATH="/opt/local/share/man:${MANPATH:-}"

# ============================================================================
# Zinit Plugin Manager
# ============================================================================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Zsh Core Plugins
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions

# Oh-My-Zsh Snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Load completions & replay cached definitions
autoload -Uz compinit && compinit
zinit cdreplay -q

# ============================================================================
# History Configuration
# ============================================================================
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# ============================================================================
# Keybindings & Navigation (Emacs mode + prefix history search)
# ============================================================================
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# ============================================================================
# Completion Styling & Live Previews (fzf-tab + eza)
# ============================================================================
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath 2>/dev/null || ls -1 --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath 2>/dev/null || ls -1 --color $realpath'

# Ensure terminal compatibility inside tmux
if [[ -n "$TMUX" ]] || [[ "$TERM" == "tmux-256color" ]]; then
    export TERM="xterm-256color"
fi

# ============================================================================
# Modern CLI Tools & Productivity
# ============================================================================

# Eza (modern colorized ls replacement)
if command -v eza &>/dev/null; then
    alias ls="eza --icons"
    alias ll="eza -la --icons --git"
    alias la="eza -a --icons"
    alias lt="eza --tree --level=2 --icons"
    alias tree="eza --tree --icons"
fi

# Bat (modern syntax-highlighted cat replacement)
if command -v bat &>/dev/null; then
    alias cat="bat --paging=never"
    export BAT_THEME="GitHub"
fi

# LazyGit alias
alias lg="lazygit"

# FZF fuzzy search defaults (using fd and bat preview)
if command -v fzf &>/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'
    export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --preview 'bat --color=always --style=numbers --line-range=:300 {} 2>/dev/null || cat {}'"
    source <(fzf --zsh)
fi

# Zoxide (smart cd: use 'z <dir>')
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
fi

# Direnv (per-directory environment variables & auto venv)
if command -v direnv &>/dev/null; then
    eval "$(direnv hook zsh)"
fi

alias ports="lsof -i -P -n | grep LISTEN"
alias myip="curl -s ifconfig.me && echo"

# Starship Prompt
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
fi
