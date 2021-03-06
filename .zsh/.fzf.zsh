# Setup fzf
# ---------
export FZF_DEFAULT_OPTS='-m -x'
export FZF_DEFAULT_COMMAND='(find * .* -type f ; find ~/* ~/.* -type f)'  
export FZF_TMUX=0
unalias fzf 2> /dev/null
unset fzf 2> /dev/null
if [[ ! "$PATH" =~ "/home/paco/.fzf/bin" ]]; then
  export PATH="/home/paco/.fzf/bin:$PATH"
fi

# Auto-completion
# ---------------
[[ $- =~ i ]] && source "/home/paco/.fzf/fzf-completion.zsh"

# Key bindings
# ------------
# CTRL-T - Paste the selected file path(s) into the command line
#__fsel() {
#  command find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
#    -o -type f -print \
#    -o -type d -print \
#    -o -type l -print 2> /dev/null | sed 1d | cut -b3- | fzf -m | while read item; do
#    printf '%q ' "$item"
#  done
#  echo
#}
__fsel() {
  command find .* * ~ -type f | fzf -m | while read item; do
    printf '%q ' "$item"
  done
  echo
}

if [[ $- =~ i ]]; then

if [ -n "$TMUX_PANE" -a ${FZF_TMUX:-1} -ne 0 -a ${LINES:-40} -gt 15 ]; then
  fzf-file-widget() {
    local height
    height=${FZF_TMUX_HEIGHT:-40%}
    if [[ $height =~ %$ ]]; then
      height="-p ${height%\%}"
    else
      height="-l $height"
    fi
    tmux split-window $height "zsh -c 'source ~/.zsh/.fzf.zsh; tmux send-keys -t $TMUX_PANE \"\$(__fsel)\"'"
  }
else
  fzf-file-widget() {
    LBUFFER="${LBUFFER}$(__fsel)"
    zle redisplay
  }
fi
zle     -N   fzf-file-widget
bindkey '^T' fzf-file-widget

# ALT-C - cd into the selected directory
fzf-cd-widget() {
  cd "${$(command find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
    -o -type d -print 2> /dev/null | sed 1d | cut -b3- | fzf +m):-.}"
  zle reset-prompt
}
zle     -N    fzf-cd-widget
bindkey '\ec' fzf-cd-widget

# CTRL-R - Paste the selected command from history into the command line
fzf-history-widget() {
  LBUFFER=$(fc -l 1 | fzf +s +m -n2..,.. | sed "s/ *[0-9*]* *//")
  zle redisplay
}
zle     -N   fzf-history-widget
bindkey '^R' fzf-history-widget

fi
