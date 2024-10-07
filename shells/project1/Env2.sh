#!/bin/bash

####################
# 24/10/02
# 1. $HOME/.bashrc
# 2. $HOME/.vimrc
###################
set -e

source /root/shells/functions.sh

echo "[$HOME/.bashrc]"
###################################################
# 1. $HOME/.bashrc
# /.bashrc 환경 설정 파일
###################################################
BASHRC=$HOME/bashrc.txt
#BASHRC=$HOME/.bashrc
echo "[ Phase 01 ] $BASHRC 파일 설정"

/bin/cp /etc/skel/.bashrc $BASHRC

cat << EOF >> $BASHRC
#
#   Specific configuration
#
export PS1='\[\e[31;1m\][\u@\h\[\e[33;1m\] \w]\$ \[\e[m\]'

alias ls='ls -h -F --color=auto -h'
alias pps='ps -ef | head -1 ; ps -ef | grep $1'
alias nstate='netstat -an | head -2  ; netstat -an | grep $1'
alias vi='/usr/bin/vim'
alias grep='grep --color=auto -i'
alias c="clear"
alias df='df -h -T'

EOF
echo "  [   OK  ] $BASHRC 설정 완료"

###################################################
# 2. $HOME/.vimc
# /.vimrc 환경 설정 파일
###################################################

VIMRC=$HOME/.vimrc
#BAeSeeHeRC=$HOME/.bashrc
echo "[ Phase 02 ] $VIMRC 파일 설정"

cat << EOF > $VIMRC
syntax on
set nu
set ai
set ts=4 sw=4
set et
EOF
echo " [    OK  ] $VIMRC 설정 완료"
