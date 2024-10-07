#!/bin/bash

# 24/10/02 server check script

# (1) server check infomation
export LANG=en_US.UTF-8
# DATE 변수 24.10.02
DATE=$(date +'%F %T')
YESNO='n'
: << EOF
while [ "$YESNO" != 'y' ]
do
    # NAME 변수
    echo
    echo -n "작성자 이름 입력(ex: soldesk): "
    read NAME
    echo; echo -n "작성자 이름: $NAME " ; echo
    echo -n "작성된 이름이 맞습니까? (Y|N): "
    read YESNO
done
EOF
# OS 변수
OS=$(cat /etc/centos-release )
# 커널 변수 
KERNEL=$(uname -sr)
# CPU 변수
CPUNUM=$(lscpu -e | tail -n +2 | wc -l)
CPUTYPE=$(echo $(cat /proc/cpuinfo | grep 'model name' | uniq | awk -F: '{print $2}'))
# CPU
CPU="$CPUNUM ($CPUTYPE)"
# RAM
MEM=$(free -h | grep '^Mem:' | awk '{print $2}')
# DISK 
DISK=$(lsblk | grep 'disk' | wc -l)

echo 
echo "-------------시작 결과 보고서-----------------"
cat << EOF
Server Vul. Checker version 1.0

DATE: $DATE
NAME: $NAME

(1) Server Information
============================================
OS : $OS 
Kernel : $KERNEL 
CPU : $CPU
MEM : $MEM
DISK : $DISK
EOF

# PASTE=() {
# ENTERLINE=$1
# for i in $ENTERLINE
# do
#     LINE="$LINE $i"
# done
# echo $LINE
# }

PASTE() {
    ENTERLINE=$*
    echo "$ENTERLINE"
}

NETINT=$(nmcli device | tail -n +2 | grep -v '^lo' | awk '{print $1}' )
for i in $NETINT
do
    NIC=$i
    IP=$(nmcli device show $i | grep 'IP4.ADDRESS' | awk '{print $2}')
    GW=$(nmcli device show $i | grep 'IP4.ROUTE' | grep 'dst = 0.0.0.0/0' | awk '{print $7}' | awk -F, '{print $1}')
    DNSLINE=$(nmcli device show $i | grep '^IP4.DNS' | awk '{print $2}')
    DNS=$(PASTE $DNSLINE)
    cat << EOF
    NETWORK: $NIC
    IP : $IP
    GW : $GW
    DNS : $DNS
EOF
done
echo "-------------끝 결과 보고서-----------------"