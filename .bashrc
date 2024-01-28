if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
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
export VISUAL=nvim
export EDITOR=nvim
alias vim=nvim
alias sudo="sudo "
# list dotfiles
alias la='ls -A'
# list dotfiles, long format
alias ll='ls -Al'
export SHELL=/bin/bash
alias tmux='tmux -2'
set -o ignoreeof

# (Ctrl-R reverse cmd search, Ctrl-T regular search, Alt-C dir search) <prefix>**<TAB> for tab complete
# `git clone https://github.com/junegunn/fzf .fzf` then `cd .fzf && ./install --bin && ln -s $HOME/bin/.fzf/bin/fzf $HOME/bin/fzf`
if [ -e $HOME/bin/.fzf/shell/key-bindings.bash ]; then
    source $HOME/bin/.fzf/shell/key-bindings.bash
fi
if [ -e $HOME/bin/.fzf/shell/completion.bash ]; then
    source $HOME/bin/.fzf/shell/completion.bash
fi
