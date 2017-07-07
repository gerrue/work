# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

function proxy_default()
{
    export HTTP_PROXY="http://http-proxy.corporate.ge.com:80";
    export HTTPS_PROXY="http://http-proxy.corporate.ge.com:80";
    export NO_PROXY=localhost,127.0.1.1,*.ge.com
}

function proxy_grc ()
{
    export HTTP_PROXY=http://proxy-src.research.ge.com:8080/;
    export HTTPS_PROXY=http://proxy-src.research.ge.com:8080/;
    export http_proxy=http://proxy-src.research.ge.com:8080/;
    export https_proxy=http://proxy-src.research.ge.com:8080/;
    export NO_PROXY=localhost,127.0.1.1,*.ge.com
}

function proxy_pitc ()
{
    export HTTP_PROXY='http://PITC-Zscaler-Americas-Cincinnati3PR.proxy.corporate.ge.com:80';
    export HTTPS_PROXY='http://PITC-Zscaler-Americas-Cincinnati3PR.proxy.corporate.ge.com:80';
    export http_proxy='http://PITC-Zscaler-Americas-Cincinnati3PR.proxy.corporate.ge.com:80';
    export https_proxy='http://PITC-Zscaler-Americas-Cincinnati3PR.proxy.corporate.ge.com:80'
    export NO_PROXY='localhost,127.0.1.1,*.ge.com'
    export no_proxy='localhost,127.0.1.1,*.ge.com'
}

function proxy_sanramon ()
{
    export HTTP_PROXY=http://sjc1intproxy01.crd.ge.com:8080;
    export HTTPS_PROXY=http://sjc1intproxy01.crd.ge.com:8080;
    export http_proxy=http://sjc1intproxy01.crd.ge.com:8080;
    export https_proxy=http://sjc1intproxy01.crd.ge.com:8080;
    export NO_PROXY=localhost,127.0.1.1,*.ge.com
}

function proxy_off ()
{
    unset HTTP_PROXY;
    unset HTTPS_PROXY;
    unset X_HTTP_PROXY;
    unset X_HTTPS_PROXY;
    unset http_proxy;
    unset https_proxy;
    unset NO_PROXY;
}

proxy_default

export CHROME_BIN=/opt/google/chrome/google-chrome

prompt() {
  ################
  # Git Repo
  git_head_output="$(git symbolic-ref HEAD 2>&1)"
  if [[ $git_head_output == *"ref HEAD is not a symbolic ref"* ]]; then
    ps1_git_status="!Detached Head!"
  elif [[ $git_head_output == *"Not a git repository"* ]]; then
    ps1_git_status=""
  else 
    ps1_git_status=${git_head_output##refs/heads/}
  fi
  if [ -n "$ps1_git_status" ]; then 
    ps1_git_status="{$ps1_git_status}"
  fi

  ################
  # Virtual Env
  if [ -n "$VIRTUAL_ENV" ]; then
    ps1_virtual_env=$(basename "$VIRTUAL_ENV")
    ps1_virtual_env="($ps1_virtual_env)"
  else 
    unset ps1_virtual_env;
  fi
  

  ################
  # PS1
  export PS1="\[\e[34m\][\t] me:\[\e[96m\]$ps1_virtual_env\[\e[93m\]$ps1_git_status \[\e[39m\]\w \[\e[34m\]$\[\e[39m\] "
}

PROMPT_COMMAND=prompt
source ~/.dotfiles/conf/bash_config.sh

