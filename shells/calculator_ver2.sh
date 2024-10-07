#!/bin/bash
# Function 생성

Error() {
    echo "연산자를 입력하지 않아 종료합니다."
    exit 0
}

# 
# 프로그램 작성 조건
# 1. 1번째 숫자값을 입력하고,
# 연산할 때 사용하는 연산자를 입력합니다.
# 2번째 숫자값을 입력하여
# 선택된 연산 결과를 출력한다.
#
# A Input
echo -n "Enter A: "
read A

# OP Input
echo -n "OP": 
read OP

# C Input
echo -n "Enter B: "
read B


case $OP in
    '+') echo "$A + $B" = $(expr $A + $B)    ;;
    '-') echo "$A - $B" = $(expr $A - $B)    ;;
    '*') echo "$A * $B" = $(expr $A \* $B)   ;;
    '/') echo "$A / $B" = $(expr $A / $B)    ;;
    *  ) Error   :   ;;
esac


