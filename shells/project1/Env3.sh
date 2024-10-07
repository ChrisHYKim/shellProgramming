#!/bin/bash

################################
#  24/10/02
# 1. epel-release 패키지 설치
# 2. boxes, gcc, make 패키지 설치
# 3. ?
################################

set -e

source /root/shells/functions.sh
echo
echo "[필요 패키지 설치]"
# 1. epel-release 패키지 설치
PKGS="epel-release"
echo "[ Phase 01 ] $PKGS 파일 설정"
PkgInstall $PKGS

# 2. boxes, gcc ,make 패키지 설치 
PKGS="gcc make boxes"
echo "[ Phase 02 ] $PKGS 패키지 설치"
PkgInstall $PKGS