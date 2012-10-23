# Path to your oh-my-zsh configuration.
ZSH=$HOME/dotfiles/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git vi-mode)

if [[ `uname` == 'Darwin' ]]; then
    plugins+=(osx macports)
    export TMPDIR=${TMPDIR:=$(getconf DARWIN_USER_TEMP_DIR)}
fi

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
PATH=/opt/local/bin:/opt/local/sbin:/opt/X11/bin:/usr/X11/bin:$PATH
[ -d /opt/local/libexec/gnubin ] && PATH=/opt/local/libexec/gnubin:$PATH

typeset -U path manpath

export PATH PAGER=less EDITOR=vim LC_ALL='en_US.UTF-8' LANG=$LC_ALL LC_TYPE=C
