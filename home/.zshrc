maybe_add_path() {
   if [ -d "$1" ]; then
      PATH="$1:$PATH"
   else
      # echo "skipping path $1, directory does not exist"
   fi
}

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export TERM=xterm-256color

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="wes"

# ~/.oh-my-zsh/plugins/*
# ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git docker docker-compose aws)

source $ZSH/oh-my-zsh.sh
[[ -e $HOME/.local-env.sh ]] && source $HOME/.local-env.sh

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"
maybe_add_path "$HOME/bin"
maybe_add_path "$HOME/.local/bin"
maybe_add_path "$HOME/code/flutter/bin"
maybe_add_path "/usr/local/go/bin"

zstyle ':completion:*:*' ignored-patterns '*ORIG_HEAD'

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

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
