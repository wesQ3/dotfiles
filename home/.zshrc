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
[[ -e $HOME/.bash_aliases ]] && source $HOME/.bash_aliases

# User configuration

export PATH="/home/wes/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"

zstyle ':completion:*:*' ignored-patterns '*ORIG_HEAD'

export DBIC_TRACE_PROFILE=console
export LIVE_TEST_SERVER=localhost
export DESTRUCTIVE_TESTS=1
export SystemDrive=/
export LYNX_DSN_PATH=/home/wes/code/sql.txt
export CIURL=http://ci.lan.mitsi.com

# use plenv
export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)
