#!/bin/bash

# 
# 프로그램 작성
# user.list 파일을 입력으로 받아 대량의 사용자를 추가하는 스크립트이다.
#

userList=/root/shells/user.list

cat $userList | while read UNAME UPASS
do
    userdel -r "$UNAME" 
    [ $? -eq 0 ] \
        && echo "   [ OK  ]  $UNAME 삭제 완료" \
        || echo "   [ FAILED ] $UNAME 삭제 에러" \
  
done