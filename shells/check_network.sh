#!/bin/bash

###########################
# 24/10/02 check network
# 1. ping 192.168.10.2
# 2. ping 8.8.8.8
# 3. ping www.google.com
###########################
# IP 지정
IP1=192.168.10.20
IP2=8.8.8.8
IP3=www.gogle.com
#  function code load
source /root/shells/functions.sh

# 1. 로컬 네트워크 ping 테스트
print_info "ping $IP1"
ping -c 3 -W 1 $IP1 > /dev/null 2>&1

if [ $? -eq 0 ]; then
    print_good "[  OK  ] Local Network Connection"
else 
    print_error "[ FAIL ] Local Network Connection"
    cat << EOF
    (1) VMWare > Edit > Virtual Network Editor
    (2) VMware > VM > Settings > Network Adapter
    (3) # ip addr
EOF
    exit 1
fi
echo
# 2. 외부 네트워크 ping 테스트
print_info "ping $IP2"
ping -c 3 -W 1 $IP2 > /dev/null 2>&1

if [ $? -eq 0 ]; then
    print_good "[  OK  ] External Network Connection"
else 
    print_error "[ FAIL ] External Network Connection"
    cat << EOF
    (ㄱ) # ip route 
EOF
    exit 2
fi

echo 
# 3. 외부 이름에 Ping 테스트
print_info "ping $IP3"
ping -c 3 -W 1 $IP3 > /dev/null 2>&1

if [ $? -eq 0 ]; then
    print_good "[  OK  ] DNS Network Connection"
else 
    print_error "[ FAIL ] DNS Network Connection"
    cat << EOF
    (ㄱ) # cat /etc/resolv.conf
EOF
    exit 3
fi
echo