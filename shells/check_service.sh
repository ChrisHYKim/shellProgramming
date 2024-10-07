#!/bin/bash


################################################################################
#
#프로그램 작성
#(주의) LANG 문제가 있을 수 있다.(export LANG=en_US.UTF-8)
#(기능1) 두대의 서버의 서비스 목록을 점검한다.
#(기능2) 자신의 서버(EX: 172.16.6.2XX)의 서비스는 active 되어 있는데 
#        상대편 서버(EX: 172.16.6.249)에 서비스가 inactive 되어 있는 목록을 출력한다.
#(기능3) 출력내용은 다음과 같다. (반드시 아래와 같이 할 필요는 없다.)
################################################################################

# 시스템 목록 명령어 
# ->(systemctl -t service | awk '{print $1, $3}' | sed -n '2,/^LOAD/p' | sed '$d')
if [ $# -ne 2  ]; then
    echo "Usage: $0 <IP1> <IP2>"
    exit 1
fi
SERVER="$1"
REMOTE="$2"

export LANG=en_US.UTF-8
TMP1=/tmp/tmp1
TMP2=/tmp/tmp2
TMP3=/tmp/tmp3
ssh "$SERVER" systemctl -t service \
    | grep -v '^●'  \
    | awk '{print $1, $3}' \
    | sed -n '2,/^LOAD/p' \
    | sed '$d' > $TMP1

ssh "$SERVER" systemctl -t service \
    
    | grep -v '^●'  \
    | awk '{print $2, $4}' >> $TMP1

ssh "$REMOTE" systemctl -t service \
    | grep -v '^●'  \
    | awk '{print $1, $3}' \ 
    | sed -n '2,/^LOAD/p' \
    | sed '$d' > $TMP2
ssh "$REMOTE" systemctl -t service \
    | grep -v '^●'  \
    | awk '{print $2, $4}' >> $TMP2

diff "$TMP1" "$TMP2" > $TMP3

echo "-------$SERVER------"
cat $TMP3 | fgrep '<' | cut -c3-
echo "-------$REMOTE ----------"
cat $TMP3 | fgrep '>' | cut -c3-
echo
