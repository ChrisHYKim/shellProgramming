#!/bin/bash
########################################
# service.sh start | stop httpd
# -> systemctl enable httpd
# -> systemctl restart httpd
########################################

if [ $# -ne 2   ]; then 
    echo "Usage: $0 <start|stop> UNIT"
    exit 1
fi
ACTION=$1
UNIT=$2
# 서비스 시작
UNIT_START(){
    systemctl enable $UNIT
    systemctl restart $UNIT
    systemctl status $UNIT
}
UNIT_STOP() {
    systemctl disable $UNIT
    systemctl stop $UNIT
    systemctl is-active $UNIT
}
EXIT() {
    echo "[FAIL] ERROR MSG"
    exit 1
}
case $ACTION in
    start)  UNIT_START  ;;
    stop)   UNIT_STOP   ;;
    *)      EXIT        ;;
esac