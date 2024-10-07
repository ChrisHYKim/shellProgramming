#!/bin/bash

if [    $# -ne 1    ]; then
    echo "Usage: $0 <scriptfile>"
    exit 1
fi
# script setting 24.09.26
SCRIPTFILE=$1
# SHELL 경로 지정
SHELLBASE=/root/shells
cat << EOF >> $SHELLBASE/$SCRIPTFILE
#!/bin/bash


EOF
chmod 700 $SHELLBASE/$SCRIPTFILE
