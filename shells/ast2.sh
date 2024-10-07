#!/bin/bash
#     *
#    **
#   ***
#  ****
# *****
MAX=5

#  첫번째 최대값을 받는다.
for i in $(seq 1 $MAX)
do
    NUM=$i
    BLACK_NUM=$(expr $MAX - $NUM)
    INIT_NUM=$(expr $MAX - $i)
    # 공백 추가
    for j in $(seq $INIT_NUM -1 1)
    do 
        echo -n ' '
    done
    # 별 출력
    for z in $(seq $i)
    do
        echo -n '*'
    done
    echo
done