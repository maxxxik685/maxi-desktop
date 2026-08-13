# --- FASTFETCH ---
fastfetch

# --- ALIASES ---
alias ls='eza --icons --group-directories-first --color=always'
alias ll='eza -lh --icons --group-directories-first'
alias lt='eza --tree --level=2 --icons'
alias la='eza -a --icons --group-directories-first'
alias lla='eza -lha --icons --group-directories-first'
alias v="nvim"
alias cl="clear"
alias sleep="systemctl suspend"
alias ff="fastfetch"
alias pc="sudo pacman"

# --- SETTINGS HISTORY ---
setopt HIST_FIND_NO_DUPS
HISTFILE=~/.config/zsh/zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY          # Общая история между вкладками
setopt HIST_IGNORE_DUPS       # Не сохранять дубликаты
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS

# --- AUTOCOMPLETOIN ---
autoload -U compinit && compinit -d ~/.config/zsh/.zcompdump
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' list-colors 'ma=48;2;60;70;113;38;2;192;202;245'
zstyle ':completion:*' cache-path ~/.cache/zsh/
typeset -U PATH path

# --- TOOLS & EXPORTS ---
export STARSHIP_CONFIG=~/.config/zsh/starship/starship.toml
export EDITOR="nvim"
export VISUAL="nvim"
eval "$(starship init zsh)"

# --- PLUGINS ---
source ~/.config/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# --- CUSTOM HIGHLITIGHT ---
typeset -A FAST_HIGHLIGHT_STYLES

FAST_HIGHLIGHT_STYLES[alias]='fg=#7dcfff,bold'                # Алиасы (голубой)
FAST_HIGHLIGHT_STYLES[command]='fg=#7aa2f7'                  # Команды (синий)
FAST_HIGHLIGHT_STYLES[unknown-token]='fg=#f7768e,bold'        # Ошибки в командах (красный)
FAST_HIGHLIGHT_STYLES[reserved-word]='fg=#bb9af7'            # Ключевые слова
FAST_HIGHLIGHT_STYLES[builtin]='fg=#7dcfff'                  # Встроенные команды
FAST_HIGHLIGHT_STYLES[function]='fg=#7aa2f7'                 # Функции
FAST_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#bb9af7'      # Флаги -a
FAST_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#bb9af7'      # Флаги --all
FAST_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#9ece6a'    # 'Строки' (зеленый)
FAST_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#9ece6a'    # "Строки" (зеленый)
FAST_HIGHLIGHT_STYLES[path]='fg=#73daca,nounderline'
FAST_HIGHLIGHT_STYLES[path-to-dir]='fg=#73daca,nounderline'
FAST_HIGHLIGHT_STYLES[comment]='fg=#565f89,italic'            # Комментарии
