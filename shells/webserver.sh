#!/bin/bash


# Apache Webserver Function (24.09.30)
ApacheWebServer() {
    systemctl disable --now nginx > /dev/null 2>&1
    /root/shells/httpd.sh
} 
# Nginx Webserver Function (24.09.30)
NginxWebServer() {
    systemctl disable --now httpd > /dev/null 2>&1
    /root/shells/nginx.sh
}
# EXIT 함수 (24.09.30)
Usage() {
    # 웹서비스 가동하고, 그외에는 비정상 종료를 진행합니다.
    if [ $# -ne 1   ]; then
        echo "Usage: $0 <httpd|nginx>"
        exit 1
    fi
}
# WEBSVC 입력 값을 받습니다.
# WEBSVC=
case "$1" in
    'httpd') ApacheWebServer ;;
    'nginx') NginxWebServer  ;;
    *)       Usage           ;;
esac