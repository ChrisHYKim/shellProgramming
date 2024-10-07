#!/bin/bash
# 11. WINDOWS AUTO FTP 파일 전송
IP=172.16.6.4 # FTP 서버 IP
UNAME=user01
UPASS=user01

ftp -n "$IP" << EOF
user $UNAME $UPASS
cd test
lcd /test
bin
bash
prompt
mput testfile.txt
quit
EOF
