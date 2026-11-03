if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# enable color support of ls and also add handy aliases
COLOR_FLAG=''
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    COLOR_FLAG='--color=always'
fi
alias lh='ls --hyperlink=always'

# remove some annoying aliases if exists by default
unalias rm 2> /dev/null
unalias cp 2> /dev/null

# proxy config if needed (can also set in /etc/environment)
# update-ca-certificates after putting certs w/ 644 permissions in /usr/local/share/ca-certificates or /usr/share/ca-certificates (depending on distro)
# may also need to update /etc/ca-certificates.conf
#export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
#export NODE_EXTRA_CA_CERTS="$SSL_CERT_FILE"
#export REQUESTS_CA_BUNDLE="$SSL_CERT_FILE"
#export NIX_SSL_CERT_FILE="$SSL_CERT_FILE"
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
export VISUAL=vim
export EDITOR=vim
export SHELL=/bin/bash
export JAVA_HOME="$(dirname $(readlink -e $(which java) e>/dev/null) 2> /dev/null)"
export GHIDRA_HOME="$(dirname $(readlink -e $(which ghidra) e>/dev/null) 2> /dev/null)"
# sudo apt install glab
#export GITLAB_TOKEN=''
#export GITLAB_HOST=''
# fix other+write background to be readable for some terminal color schemes
#export LS_COLORS=":$LS_COLORS:ow=94;42:"

alias cal='cal -A2'
alias xo='xdg-open'
alias gtags='gtags --sqlite3 --skip-symlink=a --accept-dotfiles'
alias lh='ls --hyperlink=auto'
alias fuck='sudo $(history -p \!\!)'
# make the shell expand aliases for sudo
alias sudo="sudo "
alias la='ls -A'
alias ll='ls -Al'
# Force tmux to assume the terminal supports 256 colours
alias tmux='tmux -2'
alias ctags='ctags --links=no'
alias rsync='rsync -ah --info=progress2'
alias GET_PACKAGES="find /var/lib/dpkg/info -name \"*.list\" -exec stat -c $'%n\t%y' {} \; | sed -e 's,/var/lib/dpkg/info/,,' -e 's,\.list\t,\t,' | sort -k2 > ~/.dpkglist.dates"

cpdir() {
  # usage: like cp but auto makes dirs, but path needs to be last
  # trailing slash copies to that subdir, no trailing slash treats end as file name
  local d="${@: -1}"
  [[ $d == */ ]] || d=$(dirname "$d")
  mkdir -p "$d" && cp "$@"
}

whichln() {
  local f=$(which "$1")
  if [ -n "$f" ]; then
    echo $(which "$f") "->" $(readlink -f "$f")
  fi
}

# lst [dir] [n] list long form top n most recent
lst() {
  ls -lt $COLOR_FLAG "${1:-.}" | tail -n+2 | head -n ${2:-15}
}

# lstd [files] long for sorted
lstd() {
  if [ -z "$@" ]; then
    ls -ltd $COLOR_FLAG * .* 2> /dev/null
  else
    ls -ltd $COLOR_FLAG "$@"
  fi
}

# sum of files in one or more dirs
lsc() {
  local cnt=0
  local dirs=${@:-.}
  for d in $dirs; do
    cnt="$((cnt + $(ls -1 "$d" | wc -l)))"
  done
  echo "$cnt"
}

# lsc but include dotfiles
lac() {
  local cnt=0
  local dirs=${@:-.}
  for d in $dirs; do
    cnt="$((cnt + $(ls -A1 "$d" | wc -l)))"
  done
  echo "$cnt"
}

# use the -O option to not use SFTP on older systems if that flag is available
scp() {
  if command scp 2>&1 | grep -q '\[\-.*O.*\]'; then
    command scp -O "$@"
  else
    command scp "$@"
  fi
}

# in vscode have full color matches and clickable file+lines
vsg() {
  grep -n $COLOR_FLAG "$@" | sed -E 's/^([^:]+:[^[:digit:]]+[[:digit:]]+[^:]+:)/\1 /'
}
vsrg() {
  rg -n --no-heading $COLOR_FLAG "$@" | sed -E 's/^([^:]+:[^[:digit:]]+[[:digit:]]+[^:]+:)/\1 /'
}

# vim goes to nvim if available
vim() {
  if command -v nvim > /dev/null 2>&1; then
    command nvim "$@"
  else
    command vim "$@"
  fi
}

notes() {
  local count=${1:-6}
  ls --hyperlink=always -Altd ~/notes/* | head -n "$count"
}

# convenience wrapper around python to run a command
py() {
  local cmd=''
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
    "$cmd" -c "print($1)"
  fi
}

hex() {
  printf '0x%x\n' $1
}

0x() {
  echo $((0x$1))
}

# kill all running jobs
killj() {
  jobs > /dev/null
  local running_jobs=$(jobs -p)
  if [[ -n "$running_jobs" ]]; then
    kill -9 "$running_jobs"
  fi
}

# run in background with no terminal
rbg() {
  "$@" > /dev/null 2>&1 & disown
}

IP() {
  local iface=${1:-eth0}
  ifconfig -a "$iface" | head -2 | tail -1 | tr -s ' ' | cut -d' ' -f 3
}

# if apt installed in Ubuntu, this will be in /usr/share/doc/fzf/examples/key-bindings.bash and /usr/share/bash-completion/completions/fzf
# (Ctrl-R reverse cmd search, Ctrl-T regular search, Alt-C dir search) <prefix>**<TAB> for tab complete
# `git clone https://github.com/junegunn/fzf .fzf` then `cd .fzf && ./install --bin && ln -s $HOME/bin/.fzf/bin/fzf $HOME/bin/fzf`
# or can just do eval $(fzf --bash) if new enough
#eval $(fzf --bash)
#if [ -e $HOME/bin/.fzf/shell/key-bindings.bash ]; then
#    source $HOME/bin/.fzf/shell/key-bindings.bash
#fi
#if [ -e $HOME/bin/.fzf/shell/completion.bash ]; then
#    source $HOME/bin/.fzf/shell/completion.bash
#fi
