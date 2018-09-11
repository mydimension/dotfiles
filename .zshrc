POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=false
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='%F{blue}%(!.#.$)❯%f '

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context virtualenv dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs command_execution_time date time)

AIRLINE_GREEN='148' # green from vim-airline

DEFAULT_USER=$USER
POWERLEVEL9K_ALWAYS_SHOW_USER=true
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='blue'
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='black'
POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND='red'
POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND='black'
POWERLEVEL9K_CONTEXT_SUDO_BACKGROUND=$POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND
POWERLEVEL9K_CONTEXT_SUDO_FOREGROUND=$POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND
POWERLEVEL9K_CONTEXT_REMOTE_BACKGROUND=$POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND
POWERLEVEL9K_CONTEXT_REMOTE_FOREGROUND=$POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND
POWERLEVEL9K_CONTEXT_REMOTE_SUDO_BACKGROUND=$POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND
POWERLEVEL9K_CONTEXT_REMOTE_SUDO_FOREGROUND=$POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND

POWERLEVEL9K_VIRTUALENV_BACKGROUND='black'
POWERLEVEL9K_VIRTUALENV_FOREGROUND='yellow'

POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='black'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_BACKGROUND=$POWERLEVEL9K_DIR_DEFAULT_BACKGROUND
POWERLEVEL9K_DIR_HOME_FOREGROUND=$POWERLEVEL9K_DIR_DEFAULT_FOREGROUND
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND=$POWERLEVEL9K_DIR_DEFAULT_BACKGROUND
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND=$POWERLEVEL9K_DIR_DEFAULT_FOREGROUND
POWERLEVEL9K_DIR_ETC_BACKGROUND=$POWERLEVEL9K_DIR_DEFAULT_BACKGROUND
POWERLEVEL9K_DIR_ETC_FOREGROUND=$POWERLEVEL9K_DIR_DEFAULT_FOREGROUND

POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND=$POWERLEVEL9K_DIR_DEFAULT_BACKGROUND
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND='red'

POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='black'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='black'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND=$AIRLINE_GREEN
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=$POWERLEVEL9K_VCS_CLEAN_FOREGROUND
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=$POWERLEVEL9K_VCS_CLEAN_BACKGROUND

POWERLEVEL9K_TIME_BACKGROUND=$AIRLINE_GREEN
POWERLEVEL9K_TIME_FOREGROUND='darkgreen'

POWERLEVEL9K_DATE_FORMAT=%D{%m/%d}
POWERLEVEL9K_DATE_BACKGROUND=$AIRLINE_GREEN
POWERLEVEL9K_DATE_FOREGROUND='darkgreen'

POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='red'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='black'

POWERLEVEL9K_STATUS_OK=false

source "$ZDOTDIR/.zprezto/runcoms/zshrc"

[ -f ~/.zshenv.local ] && source ~/.zshenv.local
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh
#
# for debugging
#set -xuo pipefail
