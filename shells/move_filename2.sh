#!/bin/bash

#  24/10/02 MOVEFILENAME 소스
if [ $# -ne 1 ]; then
    echo "Usage: $0 <direcotory>"
    exit 1
fi

D_WORK="$1"       	# working directory
T_FILE1=/tmp/.tmp1  	# tempory file1

# SRC, DST 변환
SRC=".els"
DST=".txt"

ls -1 $D_WORK | grep "${SRC}$" > $T_FILE1
# 파일이 존재할 경우, els -> txt 확장자로 변경
for FILE in `cat $T_FILE1`
do
    mv $D_WORK/$FILE $(echo $D_WORK/$FILE | sed "s/${SRC}$/${DST}/g")
done
