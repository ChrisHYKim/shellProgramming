#!/bin/bash

# Variables definition
LOGFILE=/var/log/messages
TIMEINSTERVAL=10 #비교 시간
TMP1="/tmp/tmp1"    # 첫번째 임시 파일
TMP2="/tmp/tmp2"    # 두번째 임시 파일
TMP3="/tmp/tmp3"    # 세번째 임시 파일

# 초기 임시 파일 생성
egrep -i 'warn|fail|error|crit|alert|emerg' $LOGFILE > $TMP1
# 초기 임시 파일과 새로운 임시 파일을 비교한다.
while true
do
    # 비교 time interval (30 sec)
    sleep "$TIMEINSTERVAL"
    
    # 새로운 임시 파일 생성
    egrep -i 'warn|fail|error|crit|alert|emerg' $LOGFILE > $TMP2

    # 초기 임시 파일과 새로운 임시 파일 비교 동작
    # * 파일의 내용이 같으면 30 sec wait 후, 다시 비교
    # * 파일의 내용이 다르면 관리자에게 메일 전송
    diff $TMP1 $TMP2 > $TMP3 && continue

    # 관리자에게 메일 전송 
    mailx -s '[ WARN ] 로그 파일 점검 요망' root < $TMP3

    # Log file retry Init
    egrep -i 'warn|fail|error|crit|alert|emerg' $LOGFILE > $TMP1
done