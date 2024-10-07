#!/bin/bash

max=5
for i in $(seq 1 $max)
do
    # 별 개수(왼쪽)
    for j in $(seq 1 $i)
    do
        echo -n '*'
    done
    echo 
done 