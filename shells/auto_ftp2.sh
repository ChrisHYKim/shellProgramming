#!/bin/bash

#프로그램 작성 (24.09.30)
#● auto_ftp.sh 스크립트를 참고하여 server.txt 파일에 
# 들어 있는 IP에 대해 업로드를 수행하는 스크립트를 작성해 보자.

SERVERLIST=/root/shells/server.txt

for i in $(cat $SERVERLIST)
do
    ftp -n $i << EOF
    user root centos
    cd /tmp
    lcd /test
    bin
    hash
    prompt  
    mput linux202.txt
    quit
EOF
done
