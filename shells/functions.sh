# Package Install function (24.09.30)
PkgInstall () {
    PKGList="$*"
    yum -q -y install $PKGList
    [ $? -eq 0 ]\
        && echo "[  OK  ] $PKGList 설치 완료" \
        || echo "[  FAIL    ] $PKGList 설치 실패" 
}

# RANDOM Index 생성 (24.09.30)
RandomIndex() {
    INDEXFILE="$1" # Index 1
    MESSAGES="$2" # Msg 2
    FILE1=/root/shells/boxlist2
    MAX=$(wc -l < $FILE1) # MAX=72
    # 랜덤 숫자 생성
    RANDNUM=$(($RANDOM% $MAX+1))
    
    BOXSTR=$(sed -n "${RANDNUM}p" "$FILE1")
    # 메시지와 박스를 같이 출력한다.
    cat << EOF > "$INDEXFILE"
    <pre>
        $(echo "$MESSAGES" | boxes -d "$BOXSTR")
    </pre>
    
EOF

}
# 
ServiceSettins(){
    :
}
# 웹 서비스 시작
ServiceStart() {
    SVC="$1"
    systemctl restart "$SVC" > /dev/null 2>&1 
    
    RET=$(systemctl is-active  $SVC) > /dev/null 2>&1
    # RET 동일할 경우 , active
    if [ "$RET" = "active"  ]; then
        echo "[ OK  ]  $SVC 서비스를 정상적으로 실행중입니다."
        systemctl enable "$SVC" > /dev/null 2>&1
    else
        echo "[ FAIL ] $SVC 서비스가 정상적으로 실행되지 않았습니다."
    fi 
}

FW_Rule() {
    RULES="$*" # http,https 서비스 추가 or nginx(http만 등록)
    FWCMD="firewall-cmd --permanent"
    FWRLD="--reload"
    for i in $RULES
    do
        FWCMD="$FW_CMD --add-service=${i}" > /dev/null 2>&1
    done
    # echo "$FW_CMD"
    firewall-cmd "$FWRLD"
    echo "[    OK   ] $* 방화벽 등록이 완료되었습니다."
    # firewall-cmd --permanent --add-service={http,https}
}
    
print_good () {
    echo -e "\x1B[01;32m[+]\x1B[0m $1"
}

print_error () {
    echo -e "\x1B[01;31m[-]\x1B[0m $1"
}

print_info () {
    echo -e "\x1B[01;34m[*]\x1B[0m $1"
}