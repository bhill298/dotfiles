if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=100000
# disable feature where Ctrl-S stops terminal updating
if [[ -t 0 && $- = *i* ]]; then
    stty -ixon
fi
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
alias sudo="sudo "
export SHELL=/bin/bash
alias tmux='tmux -2'
set -o ignoreeof
