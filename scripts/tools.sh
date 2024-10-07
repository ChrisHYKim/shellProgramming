#!/bin/bash
# FUNCTION definitions
WHO(){
    who | boxes -d santa
}

DATE (){
    date | boxes -d santa
}
# 에러 발생시 프로그램 종료
EXIT () {
    echo "[     FAIL    ] 잘못된 선택 에러 발생"
}

cat << EOF
echo "===================================================="
echo "  (1). who      (2). date     (3). pwd              "
echo "===================================================="
EOF

echo -n "번호 선택? : "
read CHOICE
echo 
# echo "$CHOICE"

case $CHOICE in 
    1) WHO  ;;
    2) DATE ;;
    3) PWD  ;;
    *) EXIT ;;
esac