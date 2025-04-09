export TERM=xterm-256color

maybe_add_path() {
   if [ -d "$1" ]; then
      PATH="$1:$PATH"
   else
      # echo "skipping path $1, directory does not exist"
   fi
}
[[ -e $HOME/.local-env.sh ]] && source $HOME/.local-env.sh

# Completion setup
autoload -U compinit; compinit
zstyle ':completion:*' completer _extensions _complete _approximate
# Use cache for commands using cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':completion:*:*' ignored-patterns '*ORIG_HEAD'
# select in menu with arrow keys
zstyle ':completion:*' menu select

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options true

zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
# Colors for files and directory
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}
# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

maybe_add_path "$HOME/bin"
maybe_add_path "$HOME/.local/bin"
maybe_add_path "/usr/local/go/bin"
maybe_add_path "$HOME/.fzf/bin"
maybe_add_path "$HOME/.cargo/bin"

# zsh vim mode
bindkey -v
export KEYTIMEOUT=5

# tpope surround
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround

export VISUAL=nvim
export EDITOR="$VISUAL"
export MTR_OPTIONS="--curses"

if [ -d $HOME/.plenv/bin ]; then
   export PATH="$HOME/.plenv/bin:$PATH"
   eval "$(plenv init -)"
fi

alias weather="curl wttr.in"
alias ocr-screen='TEMPFILE=/tmp/$$.RANDOM.png && flameshot gui --path $TEMPFILE && tesseract $TEMPFILE stdout'
alias tldr='docker run --rm -it -v ~/.local/share/tldr/:/root/.tldr/ nutellinoit/tldr'
alias jsony="perl -MJSONY -MJSON -E'print encode_json(JSONY->new->load(shift @ARGV))'"
alias ag="ag --pager='less -R'"
alias trim-clipboard="xsel -b | sed 's/  *$//' | xsel -b"
alias http-dir="plackup -MPlack::App::Directory -e 'Plack::App::Directory->new->to_app'"
alias sc="systemctl"
alias scu="systemctl --user"

# ohmyzsh/lib/directories.zsh

# Changing/making/removing directory
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -- -='cd -'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias md='mkdir -p'
alias rd=rmdir

function d () {
  if [[ -n $1 ]]; then
    dirs "$@"
  else
    dirs -v | head -n 10
  fi
}

# List directory contents
alias ls='ls --color=tty'
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'

# ohmyzsh/lib/history
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# fuzzy history search up/down keys
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search


source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

command -v fzf > /dev/null && source <(fzf --zsh)

# .config/starship.toml
eval "$(starship init zsh)"
