paths=(
    "/opt/local/bin"
    "/opt/local/sbin"
    "/opt/local/libexec/gnubin"
    "$HOME/bin"
    "$HOME/.rvm/bin"
    "/opt/local/libexec/perl5.12/sitebin"
    "/opt/local/libexec/perl5.14/sitebin"
    "/opt/local/libexec/perl5.16/sitebin"
    "/opt/local/libexec/perl5.22/sitebin"
    "/opt/local/Library/Frameworks/Python.framework/Versions/Current/bin"
)

for p in "${paths[@]}"; do
    [ -d "$p" ] && PATH="$p${PATH+:}$PATH"
done

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
export VIRTUAL_ENV_DISABLE_PROMPT=1

[ -f ~/.zshenv.local ] && source ~/.zshenv.local
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

typeset -U path manpath # remove duplicate entries

export _LOADED=$SHLVL

if [[ `uname` == 'Darwin' ]]; then
    export TMPDIR=${TMPDIR:=$(getconf DARWIN_USER_TEMP_DIR)}
fi
