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
screenfetch
archey
