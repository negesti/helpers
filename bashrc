# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/profile ]; then
  . /etc/profile
fi
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace:ignoreboth
# dont 'exit' store in history
export HISTIGNORE="&:exit"

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# dont store duplicates and exit in history
export HISTIGNORE="&:exit"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

if [ -e /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
  source /usr/share/git-core/contrib/completion/git-prompt.sh
fi

function prompt_command {
    local RETURN_CODE="$?"
    local ASCII_RESET="\[\e[0m\]"
    local ASCII_BOLD="\[\e[1m\]"
    local USER_COLOR="\[\e[1;36m\]"	# cyan
    local PROMPT_COLOR="\[\e[1;32m\]"
    local WORK_COLOR="\[\e[1;32m\]"	# green
    if [[ ${EUID} == 0 ]] ; then
        PROMPT_COLOR="\[\e[1;31m\]"
    fi
    local HOST_COLOR="\[\e[1;33m\]"	# YELLOW
    local DATE_COLOR="\[\e[1;31m\]"
    local TIME_COLOR="\[\e[1;34m\]"
    local DATE_STRING="\$(date +%m/%d)"
    local TIME_STRING="\$(date +%H:%M:%S)"
    local CYAN_COLOR="\[\e[1;36m\]"
    local PINK_COLOR="\[\e[1;35m\]"
    local GIT_COLOR="\[\e[1;33m\]"	# YELLOW

    local PROMPT_PREFIX="$PROMPT_COLOR"
    
    # include virtualenv
    if [ ! -z "$VIRTUAL_ENV" ]; then
      PROMPT_PREFIX="$DATE_COLOR`basename $VIRTUAL_ENV`$ASCII_RESET "
    fi  
    if [ ! -z "$NODE_VIRTUAL_ENV" ]; then
      PROMPT_PREFIX="$DATE_COLOR`basename $NODE_VIRTUAL_ENV`$ASCII_RESET "
    fi  


    # include last return code
    if [[ $RETURN_CODE != 0 ]] ; then
      PROMPT_PREFIX="$PROMPT_PREFIX$DATE_COLOR$RETURN_CODE$ASCII_RESET "
    fi
    # include git branch
    if [ `type -t __git_ps1`"" == 'function' ]; then
      PROMPT_PREFIX="$PROMPT_PREFIX$GIT_COLOR$(__git_ps1 "(%s)")$ASCII_RESET"
    fi

    HOST_PART=''
    if [ ! -f ~/.bash_hide_hostname ]; then
      HOST_PART=" $HOST_COLOR${HOSTNAME}"
    fi


#    PS1="$ASCII_BOLD[$USER_COLOR\u $HOST_COLOR${HOSTNAME} $WORK_COLOR\W $PROMPT_PREFIX$ASCII_RESET$ASCII_BOLD]$ASCII_RESET$PROMPT_COLOR\\\$$ASCII_RESET "
    PS1="$ASCII_BOLD[$USER_COLOR\u$HOST_PART $WORK_COLOR\W $PROMPT_PREFIX$ASCII_RESET$ASCII_BOLD]$ASCII_RESET$PROMPT_COLOR\\\$$ASCII_RESET "

}

  if [ `type -t prompt_command`"" == 'function' ]; then
    export PROMPT_COMMAND=prompt_command
  else
    export PROMPT_COMMAND=
  fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac



# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# auto correct cd commands
shopt -s cdspell

export EDITOR=vim

screenssh() {
  local SESSIONNAME="$1"
  if [ "$SESSIONNAME" != "" ]; then
    export SCREENSSH="/root/.screenssh.$SESSIONNAME"

    SSHVARS="SSH_CLIENT SSH_TTY SSH_AUTH_SOCK SSH_CONNECTION DISPLAY"
    rm -f "$SCREENSSH"
    for x in ${SSHVARS} ; do
        v=$(eval echo \$$x)
        echo "export $x=\"$v\"" >> "$SCREENSSH"
    done
    screen -dR -S "$SESSIONNAME"
  fi
}

if [ "$LC_SCREENSESSION" != "" ]; then
  SCREENSESSION="$LC_SCREENSESSION"
  unset LC_SCREENSESSION
  screenssh "$SCREENSESSION"
fi

if [ "$TERM" == "screen" -a "$SCREENSSH" != "" ]; then
  source "$SCREENSSH"
fi

# auto correct cd commands
shopt -s cdspell

if [ -d ~/.nvm ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

export EDITOR=vim

# User specific environment and startup programs
PATH=$PATH:$HOME/.local/bin:$HOME/bin
export PATH

# add the ssh key to the keyring
#tmp=`ssh-add -l`
#if [ $? -eq 1 ] ; then
#  ssh-add ~/.ssh/id2_dsa
#fi

unset XMODIFIERS

export JAVA_HOME=/usr/lib/jvm/java-11-openjdk

## barracuda vpn must use xterm
export TERM=xterm


