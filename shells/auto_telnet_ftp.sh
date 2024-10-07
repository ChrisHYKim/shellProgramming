#!/bin/bash


# 10. auto_telnet.sh + auto_ftp.sh (auto_telnet_ftp.sh) (24.09.30)
# ■ 기능
# 1. 원격 서버에 로그인하여(auto_telnet.sh) 백업(tar CMD)을 수행하고,
# 2. 백업된 파일을 자동으로 다운로드(auto_ftp.sh) 하는 스크립트를 제작한다.
IP=172.16.6.250

CMD () {
    sleep 2     ;   echo 'root'
    sleep 0.5   ;   echo 'centos'
    sleep 0.5   ;   echo 'hostname'
    sleep 0.5   ;   echo 'tar cvzf /tmp/linux250.tar.gz /home'
    sleep 0.5   ;   echo 'exit'
}

# Telnet 접속 시도 (24.09.30)
CMD | telnet "$IP"

ftp -n "$IP" << EOF
user root centos
cd /tmp
lcd /root
bin
bash
prompt
mget linux250.txt
quit

EOF
echo 
echo "-----result------"
ls -l /root/linux*.txt


