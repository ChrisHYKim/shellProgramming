#!/bin/bash

#  24/10/02 MOVEFILENAME 소스

D_WORK=/test       	# working directory
T_FILE1=/tmp/.tmp1  	# tempory file1

ls -1 $D_WORK | grep '.txt$' > $T_FILE1
# 파일이 존재할 경우, txt -> els 확장자로 변경
for FILE in `cat $T_FILE1`
do
    mv $D_WORK/$FILE `echo $D_WORK/$FILE | sed 's/.txt$/.els/g'`
done