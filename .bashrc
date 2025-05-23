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
alias lh='ls --hyperlink=always'

# proxy config if needed (can also set in /etc/environment)
# update-ca-certificates after putting certs w/ 644 permissions in /usr/local/share/ca-certificates or /usr/share/ca-certificates (depending on distro)
# may also need to update /etc/ca-certificates.conf
#export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
#export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
#export NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
#export http_proxy="http://proxy.XXX.YYY:80/"
#export https_proxy="http://proxy.XXX.YYY:80/"
#export ftp_proxy="http://proxy.XXX.YYY:80/"
#export socks_proxy="http://proxy.XXX.YYY:80/"
#export rsync_proxy="http://proxy.XXX.YYY:80/"
#export no_proxy="127.0.0.1,localhost,*.XXX.YYY,.XXX.YYY,XXX.YYY,::1,10.,172.16.,172.17.,192.168.,*.local,.local,169.254/16"
#export HTTP_PROXY="http://proxy.XXX.YYY:80/"
#export HTTPS_PROXY="http://proxy.XXX.YYY:80/"
#export FTP_PROXY="http://proxy.XXX.YYY:80/"
#export NO_PROXY="127.0.0.1,localhost,*.XXX.YYY,.XXX.YYY,XXX.YYY,::1,10.,172.16.,172.17.,192.168.,*.local,.local,169.254/16"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000000
HISTFILESIZE=1000000

# disable feature where Ctrl-S stops terminal updating
if [[ -t 0 && $- = *i* ]]; then
    stty -ixon
fi

# Ctrl-D doesn't kill the shell
set -o ignoreeof

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export VISUAL=nvim
export EDITOR=nvim
export SHELL=/bin/bash
# fix other+write background to be readable for some terminal color schemes
#export LS_COLORS=":$LS_COLORS:ow=94;42:"

alias vim=nvim
alias sudo="sudo "
# list dotfiles
alias la='ls -A'
# list dotfiles, long format
alias ll='ls -Al'
alias tmux='tmux -2'
alias FUCK='sudo $(history -p \!\!)'
alias ctags='ctags --links=no'
alias IP="ifconfig -a etho0 | head -2 | tail -1 | tr -s ' ' | cut -d' ' -f 3"
# store apt installed packages with dates
alias GET_PACKAGES="find /var/lib/dpkg/info -name \"*.list\" -exec stat -c $'%n\t%y' {} \; | sed -e 's,/var/lib/dpkg/info/,,' -e 's,\.list\t,\t,' | sort -k2 > ~/.dpkglist.dates"
# launch in background
lbg() {
    $@ > /dev/null 2>&1 & disown
}
lsc() {
    ls -l "$@" | echo $(($(wc -l) -1))
}
lac() {
    ls -Al "$@" | echo $(($(wc -l) -1))
}
# these are to be used in vscode to have full color in matches and clickable file + lines
# I use sed here, which is unfortunate because it doesn't have non-greedy widcards
# this is also complicated by the fact that we have to work around color control codes
vsg() {
    grep -n --color=always "$@" | sed -E 's/^([^:]+:[^[:digit:]]+[[:digit:]]+[^:]+:)/\1 /'
}
vsrg() {
    rg -n --no-heading --color=always "$@" | sed -E 's/^([^:]+:[^[:digit:]]+[[:digit:]]+[^:]+:)/\1 /'
}
notes() {
    # need to replace / with \/ and also delete the first ls line
    #ls -Altd ~/notes/* | sed 1d | head -n 6 | sed "s/${HOME//\//\\/}/~/"
    count=$1
    if [ -z "$count" ]; then
        count=6
    fi
    ls --hyperlink=always -Altd ~/notes/* | head -n $count
}
hex() {
    echo 0x$((16#$1))
}
0x() {
    echo $((0x$1))
}
py() {
    cmd=''
    if type python3 &> /dev/null; then
        cmd='python3'
    elif type python &> /dev/null; then
        cmd='python'
    elif type python2 &> /dev/null; then
        cmd='python2'
    fi
    if [ -z "$cmd" ]; then
        echo 'python not found'
    else
        $cmd -c "print($1)"
    fi
}

# kill all running jobs
function killj {
    # clear the running jobs list first
    jobs > /dev/null
    running_jobs=$(jobs -p)
    if [[ -n "$running_jobs" ]]; then
        kill -9 $running_jobs
    fi
}

# (Ctrl-R reverse cmd search, Ctrl-T regular search, Alt-C dir search) <prefix>**<TAB> for tab complete
# `git clone https://github.com/junegunn/fzf .fzf` then `cd .fzf && ./install --bin && ln -s $HOME/bin/.fzf/bin/fzf $HOME/bin/fzf`
if [ -e $HOME/bin/.fzf/shell/key-bindings.bash ]; then
    source $HOME/bin/.fzf/shell/key-bindings.bash
fi
if [ -e $HOME/bin/.fzf/shell/completion.bash ]; then
    source $HOME/bin/.fzf/shell/completion.bash
fi
