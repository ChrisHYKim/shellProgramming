#!/bin/bash
# copy.sh (24.09.30) 호스트이름 전체 복사
if [ $# -eq 0   ]; then
    echo "Usage: $0 <CMD OPTIONS ARGS>"
    exit 1
fi

SRC="$1"
DST="$2"

SERVER_LISTS=/root/shells/server.txt
# 서버 리스트 생성 (24.09.30)
cat << EOF > $SERVER_LISTS
172.16.6.250
172.16.6.206
172.16.6.204
EOF

for i in $(cat $SERVER_LISTS)
do
    echo "-----  $i -----"
    # SCP 원격 파일 전송 (24.09.30) 한다.
    scp "$SRC" "$i:$DST"
    echo
done


