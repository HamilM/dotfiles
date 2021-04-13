autoload -U promptinit; promptinit
prompt pure
# User configuration

alias ar="adb shell -t su "
alias a="adb shell"
alias ad="adb devices -l"
alias ls="lsd"
alias gs="git status"

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

export EDITOR=nvim
neofetch -L


# if [ -z "${RANGER_LEVEL}" ]; then exec ranger; fi

bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey "ã" fzf-cd-widget

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=80%
--multi
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
--prompt='∼ ' --pointer='▶' --marker='✓'
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-e:execute(echo {+} | xargs -o vim)'
"

export FZF_DEFAULT_COMMAND="find ."
#--preview-window=:hidden

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init -)"
fi
# eval "$(pyenv virtualenv-init -)"

export DEFAULT_USER="$(whoami)"
# mount the android file image
[ -z "$TMUX" ] && { tmux -f ~/.config/tmux/tmux.conf attach || exec tmux -f ~/.config/tmux/tmux.conf new-session && exit; }
