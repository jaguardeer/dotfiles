# this script is executed by interactive shells
#
[ -f ~/.zsh/zbell.zsh ] && source ~/.zsh/zbell.zsh

# use fzf
[ -f ~/.zsh/.fzf.zsh ] && source ~/.zsh/.fzf.zsh
# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
#
#
#   add some fuzzy functions
fe() {
  local file
  file=$(fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-*} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fh - repeat history
fh() {
  eval $(([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s | sed 's/ *[0-9]* *//')
}

# fkill - kill process
fkill() {
  ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9}
}



# use z
export _Z_DATA="$HOME/.z/.z"
. ~/.z/z.sh




# Lines configured by zsh-newuser-install
HISTFILE=$ZDOTDIR/.histfile
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
setopt correct
#setopt cshjunkiequotes
setopt extended_glob
#setopt globdots
#setopt noclobber


# my stuff:
export EDITOR=vim

#colors
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
alias igrep='egrep -i'				#case insensitive

alias ls='ls --color=tty --group-directories-first'
alias dir='ls --color=auto --format=vertical'

zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
autoload -Uz compinit
compinit

# ls abbrevs
alias ll='ls -laX'
alias la='ls -a'

# history abbrevs
alias h='history 1 | igrep'

#open all code files in 2 splits
alias vims='vim -O2 *.cpp *.h'

#suffix aliases
alias -s c=vim
alias -s cpp=vim
alias -s h=vim

#safer mv/cp
alias mv='mv -i'
alias cp='cp -i'
#verbose rm
#alias rm='rm -v'

#set prompt (solarized) (with bell)
export PS1="%F{100}%!%F{32}%~ %F{62}%# %f"
#adjust for SSH
if test $SSH_CLIENT
then
	export PS1='%F{red}%!%F{magenta}%~ $ %F{white}'
	export RPS1='%F{green}%n%F{yellow}@%F{red}%M%F{white}'
fi
#adjust for TMUX
if test $TMUX
then
	export TERM='screen-256color' #MOSTLY WORKS EXCEPT FOR LESS
	alias man='TERM=xterm-256color man'
	alias less='TERM=xterm-256color less'
	export RPS1=''
fi


