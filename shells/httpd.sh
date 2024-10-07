#!/bin/bash

set -e

########################################################
# 1) 패키지 설치 - httpd, mod_ssl (-q 옵션 과정 표시 숨김)
# 2) 웹 서비스 설정 - /var/www/html/index.html
# 3) 웹 서비스 기동 - httpd.service
# 4) 방화벽 등록 - http,https
#########################################################

# The File (functions.sh) load
. /root/shells/functions.sh

#
#   Main Function
#

# 1) 패키지 설치 - httpd, mod_ssl
echo " [Phase: 01 ] 패키지 설치"
PkgInstall httpd mod_ssl

# 2) 웹 서비스 설정 - /var/www/html/index.html
echo "[Phase 02] 웹 서비스 설정"
RandomIndex "/var/www/html/index.html" "My HTTPS Web Server"
echo "[ OK  ] 웹페이지가 정상적으로 가져왔습니다."

# 3) 웹 서비스 기동 - httpd.service
echo "[Phase 03] 웹서비스 실행"
ServiceStart httpd.service
# 4) 방화벽 등록 - http,https
echo "[Phase 04] 방화벽 실행"
FW_Rule http, https