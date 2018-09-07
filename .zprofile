source "$ZDOTDIR/.zprezto/runcoms/zprofile"

#source "$ZDOTDIR/aliasrc"
#alias jobs='jobs -l'
alias j='jobs'
alias grep='grep --color=always'
alias view='vi -R'
alias path='echo -e ${PATH//:/\\n}'
alias vi='vim'
alias sshpass='ssh -o preferredauthentications=password'

[ "$OSTYPE" != 'darwin10.0' ] && alias w='w -u'

[ -f /Applications/MacPorts/MacVim.app/Contents/MacOS/Vim ] &&
    alias gvim="/Applications/MacPorts/MacVim.app/Contents/MacOS/Vim -g"

alias g='gvim --remote-tab-silent'

#alias screen='screen-ssh-agent ; screen'
#alias fixssh=". $HOME/.screen/session-variables"
#alias s='fixssh; ssh'

# a slightly cleaner approach to what the above is doing.
# now just use the following in .screenrc:
#   unsetenv SSH_AUTH_SOCK
#   setenv SSH_AUTH_SOCK $HOME/.screen/ssh-auth-sock.$HOSTNAME
_ssh_auth_save() {
    [ -d "$HOME/.screen/" ] || mkdir -m 700 "$HOME/.screen/";
    if [ "$SSH_AUTH_SOCK" != "$HOME/.screen/ssh-auth-sock.$HOSTNAME" ] ; then
        ln -sf "$SSH_AUTH_SOCK" "$HOME/.screen/ssh-auth-sock.$HOSTNAME"
    fi
}
alias screen='_ssh_auth_save ; export HOSTNAME=$(hostname) ; screen'
alias tmux='_ssh_auth_save ; export HOSTNAME=$(hostname) ; tmux'

# 'ls' family
alias ls='ls -hFv $LS_OPTIONS'
alias ll='ls -l'
alias la='ls -Al'
alias l='la'
alias lx='ls -lXB'
alias lk='ls -lSr'
alias lc='ls -lcr'
alias lu='ls -lur'
alias lt='ls -ltr'

alias tree='tree --dirsfirst -FCI .svn'

# hex dump a file
alias hd='od -Ax -tx1z -v'
alias realpath='readlink -f'

alias cmdstat="history | awk {'print \$2'} | sort | uniq -c | sort -k1 -rn | head"

#alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde --read-functions'

# number base conversions
alias d2h="perl -e 'printf qq|%X\n|, int( shift )'"
alias d2o="perl -e 'printf qq|%o\n|, int( shift )'"
alias d2b="perl -e 'printf qq|%b\n|, int( shift )'"
alias h2d="perl -e 'printf qq|%d\n|, hex( shift )'"
alias h2o="perl -e 'printf qq|%o\n|, hex( shift )'"
alias h2b="perl -e 'printf qq|%b\n|, hex( shift )'"
alias o2h="perl -e 'printf qq|%X\n|, oct( shift )'"
alias o2d="perl -e 'printf qq|%d\n|, oct( shift )'"
alias o2b="perl -e 'printf qq|%b\n|, oct( shift )'"
