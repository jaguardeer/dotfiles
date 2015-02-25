# this script is executed by interactive shells

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=800
SAVEHIST=800
setopt autocd
unsetopt beep
setopt aliases
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/paco/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
setopt histignorespace


# my stuff:
export EDITOR=vim

#colors
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour

alias ls='ls -1 -s -h --color=tty --group-directories-first'
alias dir='ls --color=auto --format=vertical'

zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
autoload -Uz compinit
compinit

#ls abbrevs
alias ll='ls -laX'
alias la='ls -a'

#tmux abbrevs
alias tma='tmux a -t'
alias tks='tmux kill-server'

#history abbrevs
alias h='history'

#open all code files in 2 splits
alias vims='vim -O2 *.cpp *.h'

#safer mv/cp
alias mv='mv -i'
alias cp='cp -i'
#verbose rm
#alias rm='rm -v'

#set prompt
export PS1=$'%F{cyan}%!%F{green}%~ $ %F{white}'
