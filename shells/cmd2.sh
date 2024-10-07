#!/bin/bash

if [ $# -eq 0   ]; then
    echo "Usage: $0 <CMD OPTIONS ARGS>"
    exit 1
fi

CMD="$*"

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
    ssh "$i" "$CMD"
    echo
done
