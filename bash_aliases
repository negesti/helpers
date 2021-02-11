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
alias fm4='mplayer https://orf-live.ors-shoutcast.at/fm4-q2a -cache 2048 '

alias bc='bc -l'

