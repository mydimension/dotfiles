[ -d /opt/local/bin            ] && PATH=/opt/local/bin:$PATH
[ -d /opt/local/sbin           ] && PATH=/opt/local/sbin:$PATH
[ -d /opt/local/libexec/gnubin ] && PATH=/opt/local/libexec/gnubin:$PATH
[ -d ~/bin                     ] && PATH=~/bin:$PATH
[ -d ~/.rvm/bin                ] && PATH=$PATH:~/.rvm/bin
[ -d /opt/local/Library/Frameworks/Python.framework/Versions/Current/bin ] && PATH=/opt/local/Library/Frameworks/Python.framework/Versions/Current/bin:$PATH

export PATH
export PAGER=less
export EDITOR=vim
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LC_TYPE=C
export ZDOTDIR=~/dotfiles
export HISTFILE=~/.zhistory
export HISTSIZE=1000
export SAVEHIST=1000
export HOSTNAME=`hostname`

[ -f ~/.zshenv.local ] && source ~/.zshenv.local

typeset -U path manpath # remove duplicate entries

export _LOADED=$SHLVL

if [[ `uname` == 'Darwin' ]]; then
    export TMPDIR=${TMPDIR:=$(getconf DARWIN_USER_TEMP_DIR)}
fi
