export ZDOTDIR=~/dotfiles
export HISTFILE=~/.zhistory
export HISTSIZE=1000
export SAVEHIST=1000
export HOSTNAME=`hostname`

export PATH=/opt/local/bin:/opt/local/sbin:/opt/X11/bin:/usr/X11/bin:$PATH
[ -d /opt/local/libexec/gnubin ] && export PATH=/opt/local/libexec/gnubin:$PATH

export PAGER=less
export EDITOR=vim
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LC_TYPE=C

[ -f ~/.zshenv.local ] && source ~/.zshenv.local

typeset -U path manpath # remove duplicate entries

export _LOADED=$SHLVL

if [[ `uname` == 'Darwin' ]]; then
    export TMPDIR=${TMPDIR:=$(getconf DARWIN_USER_TEMP_DIR)}
fi
