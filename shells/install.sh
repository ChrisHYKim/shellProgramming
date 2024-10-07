#!/bin/bash

#  24/10/02 install.sh
#   (출력 결과)
#   10%|=>
#   20%|==>
#   30%|===>
#   40%|====>
#   .....
#   90%|=========>
#   100%|==========| complete
#

for i in `seq 1 10`
do
    PER=$(expr $i \* 10)
    
    # 퍼센트 표시
    echo -ne "$PER% "

    # 시작 지점 표시
    START=1

    while [ $START -le $i ]
    do
        # 진행바 생성 24.10.02
        echo -ne "==="
        # 시작점 증가 
        START=`expr $START + 1`
    done 
    # 퍼센트 값이 0이상일 경우,
    if [ $i -ne 0 ]; then 
        echo -ne '>\n' 
    else 
        echo -ne '| compleate'
    fi
done