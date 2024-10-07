#!/bin/bash

# 인자값이 1개 이상 초과시, 비정상 종료를 반환
if [ $# -ne 1   ]; then 
    echo "Usage: $0 <filename>"
    exit 1
fi
# $ 표시에 "" 제시하도록 한다.
FILENAME="$1"
FILESIZE=$(wc -c < "$FILENAME") 

# 5120 byte 큰 경우, Big Size 출력
if [ "$FILESIZE" -ge 5120 ]; then
    echo "[ INFO  ] $FILENAME($FILESIZE): Big Size"
# 5120 byte 작은 경우, Smail Size 출력
else
    echo "[ INFO  ] $FILENAME($FILESIZE): Smail Size"
fi