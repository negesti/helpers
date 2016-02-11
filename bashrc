# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace:ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

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

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

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

    PS1="$ASCII_BOLD[$USER_COLOR\u $WORK_COLOR\W $PROMPT_PREFIX$ASCII_RESET$ASCII_BOLD ]$ASCII_RESET$PROMPT_COLOR\\\$$ASCII_RESET "

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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lF'
alias la='ls -A'
alias lh='ls -lh'
alias ldir='ls | nl'
alias lx='ls -lXB'      # sort by extension
alias lr='ls -lR'       # recursive ls
alias lt='ls -ltrh'     # sort by date
alias xpwd='pwd | xclip -selection clipboard'

# everybody needs music :)
alias fm4='mplayer http://mp3stream1.apasf.apa.at:8000 '
alias fm4-ms='mplayer mms://apasf.apa.at/fm4_live_worldwide -cache 512 '

alias bc='bc -l'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# auto correct cd commands
shopt -s cdspell
# dont store duplicates and exit in history
export HISTIGNORE="&:exit"



export NVM_DIR="/home/nesta/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export EDITOR=vim
