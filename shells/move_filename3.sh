#!/bin/bash

#  24/10/02 MOVEFILENAME 소스
if [ $# -ne 3 ]; then
    echo "Usage: $0 <direcotory> <src extension> <dst extension>"
    exit 1
fi

D_WORK="$1"       	# working directory
# SRC, DST 변환
SRC=".$2"
DST=".$3"
T_FILE1=/tmp/.tmp1  	# tempory file1

# ls -1 $D_WORK | grep "${SRC}$" > $T_FILE1
find $D_WORK | grep  "${SRC}$" > $T_FILE1
# 파일이 존재할 경우, els -> txt 확장자로 변경
for FILE in `cat $T_FILE1`
do
    mv $FILE $(echo $FILE | sed "s/${SRC}$/${DST}/g")
done

