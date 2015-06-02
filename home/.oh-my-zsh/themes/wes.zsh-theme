# vim:ft=zsh ts=2 sw=2 sts=2

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo 'ッ'
}

PROMPT='
%{$fg[green]%}%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%} %{$fg[yellow]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info)
$(prompt_char) '

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$FG[228]%}⤴ "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[009]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

