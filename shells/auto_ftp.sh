#!/bin/bash

# 24.09.30 LocalIP 파일전송
ftp -n 127.0.0.1 21 << EOF
user root centos
cd /tmp
lcd /test
bin
hash
prompt
mput testfile.txt
quit
EOF

