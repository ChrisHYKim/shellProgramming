#!/bin/bash

####################
# 24/10/02
# 1. telnet 서비스
# 2. vsftpd 서비스
###################
set -e

source /root/shells/functions.sh
###################################################
# 1. telnet service
# 1) 패키지 설치 
#    yum -y install telnet-server, telnet (telnet*)
# 2) 서비스 기동
#    systemctl enable telnet.socket
#    systemctl restart telnet.socket
# 3) 방화벽 등록
#     telnet
###################################################
# 1. Telnet 패키지 설치 
PKGS="telnet-server telnet"
echo "[Phase 01. $PKGS 패키지 설치]"
PkgInstall $PKGS
# 2. Telnet 서비스 시작
SVCS="telnet.socket"
echo "[Phase 02. $SVCS 서비스 시작"]
ServiceStart $SVCS
#  3. Telnet 방화벽
FWROLE="telnet"
echo "[Phase 03. $FWROLE 방화벽 등록"]
FW_Rule $FWROLE

echo
###################################################
# 2) vsftpd 서비스 
# 1) 패키지 설치
#   vsftpd, ftp
# 2) 서비스 설정
#   /etc/vsftpd/{ftpusers, user_list}
# 3) 서비스 기동
#   systemctl enable vsftpd.service
#   systemctl start/restart vsftpd.service
# 4) 방화벽 등록
#   ftp
###################################################

PKGS="vsftpd ftp"
echo "[Phase 1. $PKGS 설치]"
PkgInstall $PKGS

FTPUSERS=/etc/vsftpd/ftpusers
USER_LIST=/etc/vsftpd/user_list
echo "[Phase 2.$FTPUSERS $USER_LIST 서비스 설정 ]"
for i in $FTPUSERS $USER_LIST
do
    sed -i 's/^root/#root/' $i
done
echo "[ OK  ] ROOT 사용자 등록 완료"

SVCS="vsftpd.service"
echo "[Phase 03. $SVCS 서비스 시작"]
ServiceStart $SVCS

echo "4. 방화벽 등록"
FWROLE="ftp"
echo "[Phase 04. $FWROLE 방화벽 등록"]
FW_Rule $FWROLE
