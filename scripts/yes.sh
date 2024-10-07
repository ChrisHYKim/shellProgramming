#!/bin/bash
# function
YES (){
    echo "YES" | boxes -d santa
}
NO (){
    echo "NO" | boxes -d santa
}
FAIL() {
    echo "[FAIL] ERROR MSG"
    exit 2
}
echo -n "선택? (yes/no): "
read CHOICE

case $CHOICE in 
    y|Y|yes|YES|Yes)   YES;;
    n|N|no|NO|No)      NO;;
    *)                 FAIL;;
esac