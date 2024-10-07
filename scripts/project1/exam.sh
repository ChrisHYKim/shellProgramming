#!/bin/bash

# 문제 번호 지정
NUM=1
BASEDIR=$HOME/scripts/project1
TOTAL_NUM=$(wc -l < $BASEDIR/question/answer.txt)
# TEMP 파일 지정
TMP=/tmp/tmp1
# FUNCTION CRAETE
Prob_VIEW() {
    echo
    cat $1
    echo
}

ls -1 $BASEDIR/question/question*.txt > $TMP1

# main Function
while [ $NUM -le $TOTAL_NUM ]
do
    PROB_FILE=$BASEDIR/question/question$NUM.txt
    Prob_VIEW $PROB_FILE
    CORRECT_NUM=$(cat $BASEDIR/question/answer.txt \
                    | sed -n "${NUM}p" \
                    | awk -F: '{ print $2 }' )
    echo -n "정답은? (1|2|3|4): "
    read ANSWER
    # echo $ANSWER
    if [ "$ANSWER" = "$CORRECT_NUM" ]; then
        echo "[  OK  ]: 정답입니다."
        NUM=$(expr $NUM + 1)
    else
        echo "[ FAIL ]: 오답입니다."
    fi
done

echo
echo "[ OK  ] : 합격하셨습니다." | boxes -d santa
echo