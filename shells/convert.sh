#!/bin/bash

# 24/10/02
# ■ 파일명: convert.sh
# ■ 기능
# ● 파일 형식 변경 스크립트
# ● convert.sh 스크립트는 ouptput.txt 파일을 입력으로 받아서 파일 내용을 컴마(,) 구분자를 갖는 파일로 내용을 변경하고, 
# output.csv로 확장자를 생성하는 스크립트이다.
INPUTFILE=/share/output.txt
OUTFILE=/share/output.csv
> $OUTFILE
# 1. output.txt 파일을 읽어들여서, OUTFILE 구성합니다.
cat $INPUTFILE | while read ID NAME EMAIL PHONE ADDR
do
    echo "$ID,$NAME,$EMAIL,$PHONE,$ADDR" >> $OUTFILE
done 
# 2. OUTPUTFILE 결과값 출력
cat $OUTFILE