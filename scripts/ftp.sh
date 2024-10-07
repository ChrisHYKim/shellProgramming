#!/bin/bash

Help ()
{
cat << EOF
        Commands may be abbreviated.  Commands are:

        !		debug		mdir		sendport	site    
        $		dir		mget		put		size
        account		disconnect	mkdir		pwd		status
EOF
}
INVALID () {
    echo "Invalid Command"
}

Open() {
    echo -n "접속할려는 서버 IP: "
    read IP1
    # echo $IP1
    ftp $IP1
}

Quit() {
    exit 0
    echo "Exit FTP"
}
# 나가기
EXIT ()
{
    echo "ftp quit"
}
while true
do
    echo -n "Myftp> "
    read CMD
    # echo $CMD

    case $CMD in 
        'help' ) Help    ;;
        'open' ) Open    ;;
        'quit' ) Quit    ;;
        '')      :       ;;
        *)       INVALID ;;
    esac
done