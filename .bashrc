#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
alias msfconsole="msfconsole --quiet -x \"db_connect shovanrai@msf\""
alias graph='git log --decorate --all --graph'
alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
alias logout='pkill -KILL -U shovanrai'
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh
