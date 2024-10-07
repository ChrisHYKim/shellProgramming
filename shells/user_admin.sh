#!/bin/bash

# PASSWD 체크
PASSWD=/etc/passwd
# Function Menu, UserAdd, UserVerity, UserDel
Menu() 
{
cat<< EOF
    (관리 목록)
------------------------------------
    1) 사용자 추가
    2) 사용자 확인
    3) 사용자 삭제
    4) 종료
------------------------------------
    
EOF
}

USERAdd()
{
    echo ""
    echo "{사용자 추가}"
    echo -n "추가할 사용자: "
    read UNAME

    useradd $UNAME > /dev/null 2>&1
    [ $? -eq 0] \
        && echo "[  OK  ] 정상적으로 생성하였습니다." \
    || echo "[ FAIL] 생성을 실패하였습니다." 
    echo $USNAME | passwd --stdin $UNAME  > /dev/null 2>&1
}

USERVerify() {
    cat << EOF
    (사용자 확인)
------------------------------------
    
$(awk -F: '$3 >= 1001 && $3 <= 60000 {print $1} ' /etc/passwd | nl)

------------------------------------

EOF
}
# USER DEL Function
UserDel() 
{   
    echo "(사용자 삭제): "
    echo -n "삭제할 사용자 이름: "
    read UNAME

    userdel -r $UNAME
    [ $? -eq 0 ] \
        && echo " [ OK  ] 정상적으로 삭제되었습니다." \
    || echo " [ FAIL    ]  정상적으로 삭제되지 않았습니다."

}
while true
do
    Menu
    echo -n "선택 번호?(1|2|3|4) : "
    read NUM
    
    case $NUM in
        1) USERAdd : ;;
        2) USERVerify : ;;
        3) UserDel : ;;
        4) break;;
        *) echo " [WARN ] 잘못 입력하셨습니다.";;
    esac
done