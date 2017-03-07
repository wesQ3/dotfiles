# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export TERM=xterm-256color

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="wes"

# ~/.oh-my-zsh/plugins/*
# ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh
[[ -e $HOME/.local-env.sh ]] && source $HOME/.local-env.sh

# User configuration

export PATH="/home/wes/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"

zstyle ':completion:*:*' ignored-patterns '*ORIG_HEAD'

# use plenv
export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"

alias weather="curl wttr.in"

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)
