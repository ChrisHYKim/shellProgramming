#!/bin/bash
SERVER_LIST=/root/shells/server.list
# IP, USERNAME,PASSWD 조회 작업 진행 (24.09.30)
cat $SERVER_LIST | while read IP UNAME UPASS
do
    Cmd() {
	    sleep 2 ; echo "$UNAME"
	    sleep 1 ; echo "$UPASS"
	    sleep 1 ; echo 'hostname'
	    sleep 1 ; echo 'ls -l'
	    sleep 1 ; echo 'exit'   
    }
    Cmd | telnet "$IP" 
done