DEFAULT_USER=$USER
ZSH_AUTOSUGGEST_USE_ASYNC=true

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/dotfiles/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


source "$ZDOTDIR/.zprezto/runcoms/zshrc"

[ -f ~/.zshenv.local ] && source ~/.zshenv.local
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh
#
# for debugging
#set -xuo pipefail

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/william/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/william/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/william/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/william/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# To customize prompt, run `p10k configure` or edit ~/dotfiles/.p10k.zsh.
[[ ! -f ~/dotfiles/.p10k.zsh ]] || source ~/dotfiles/.p10k.zsh
