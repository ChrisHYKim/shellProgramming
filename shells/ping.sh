#!/bin/bash

# Ping Test code (24.10.02)

START=200
END=230
NET=172.16.6
RESULTTMP=/tmp/tmp1
for i in $(seq $START $END)
do
    ping -c 1 -W 0.5 $NET.$i >/dev/null 2>&1
    # 동작하는 PING IP 대역 -OK, 그외에는 FAIL 반환한다.
    [ $? -eq 0  ] \
        && echo "[  OK   ] The  $NET.$i " | tee -a $RESULTTMP \
        || echo "{  FAIL } The  $NET.$i " >> $RESULTTMP
    
done