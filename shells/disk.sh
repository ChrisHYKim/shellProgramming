#!/bin/bash

# 프로그램 조건
# (전체 조건) -> /dev/sdb 조건 여부
# (작업 절차)
# 1. 새 파티션 생성 (/dev/sdb1)
# 2. 파일 시스템 (mkfs.xfs)
# 3. 마운트 작업 진행 (언마운트 작업도 추가)

# 1. dev/sdb1 존재하지 않을 경우, 커멘드 실행
diskCMD() {
    sleep 1 ; echo 'p\n' >> /dev/null 2>&1 
    sleep 1 ; echo 'n\n' >> /dev/null 2>&1
    sleep 1 ; echo 'p\n' >> /dev/null 2>&1 
    sleep 1 ; echo '\n'  >> /dev/null 2>&1
    sleep 1 ; echo '\n'  >> /dev/null 2>&1
    sleep 1 ; echo '\n'  >> /dev/null 2>&1
    sleep 1 ; echo 'w\n' >> /dev/null 2>&1
}
# 디스크 상태 체크
diskCheckInfo() {
    # diskname, disk경로, disk파티션 영역 체크 (24.09.30)
    diskname=$(lsblk -a /dev/sdb | awk '/disk/ {print $1;}')
    diskCMD=$(fdisk -l /dev/$diskname | grep "/dev/sdb1" | awk '{print $1}')

    # 디스크 존재 여부 체크 (sdb1 존재 여부를 찾습니다.)
    if lsblk | grep -q 'sdb1'  ; then
        echo "[ OK ] $diskCMD 디스크가 존재합니다."
    else 
        # 현재 디스크가 존재하지 않을 때만 포맷 작업을 진행합니다.
        echo "[   FAIL  ] $diskCMD 디스크가 존재하지 않습니다. 새로운 파티션을 생성합니다."
        fdisk_result=$(fdisk /dev/sdb)
        if ! $fdisk_result ; then
            echo "fdisk 실행 에러 $?">&2
        fi
        # 1. 파티션 포맷 완료
        diskCMD | $fdisk_result
        partprobe $diskCMD
        echo "=======Result Partion======"
        echo "  디스크 포맷 완료  "
        echo "==========================="
    fi
}
# 2. mkfs.xfs 작업 진행
xfsFormat() {
    # 파일시스템 조회 명령어 
    diskfileSys=$(lsblk --fs /dev/sdb1 2>&1)
    if echo "$diskfileSys" | grep -q 'xfs'; then
        echo '[ OK ] 이미 XFS으로 작업한 디스크입니다.'
    else 
        mkfs.xfs "/dev/sdb1" >> /dev/null 2>&1
        echo "========Result====================="
        echo "/dev/sdb1 을 xfs 파일 포맷완료."
    fi
}

# 3. 디스크 mount 등록을 진행합니다.
mountDiskProc() {
    mount_uuid=$(blkid "$diskPartion" | grep "UUID" | cut -d '"' -f 2) 
    mount_dir="$HOMEDIR/diskProc"
    sysreload="daemon-reload"
    # echo $mount_dir
    if [  -d "$mount_dir"  ]; then
        echo "이미 존재하는 디렉토리입니다. $mount_dir"
        echo "=====result mount====="
        mount "/dev/sdb1" "$mount_dir"
        # 마운트 값이 존재할 경우,
        if grep -q "$mount_uuid"  /etc/fstab; then
            echo " [   OK  ] 이미 마운트 포인트 존재합니다."
            # 주석 해제 명령
            sed -i '63s/^#//' /etc/fstab 
            systemctl "$sysreload"
            df -hT | boxes -d santa
        else
            sed -i '60,62i\#\n# (8) disk1.sh configuration\n#\nUUID='"$mount_uuid"' '"$mount_dir"' xfs defaults 0 2' /etc/fstab
            systemctl "$sysreload"
        fi
    else 
        mkdir -p $mount_dir
        echo "------result-------------"
        echo "마운트 디렉토리 ($mount_dir) 생성을 완료합니다."
        echo "-------------------------"
    fi
    # 4. umount 작업 진행
    if mountpoint -q $mount_dir; then
        umount "$mount_dir"
        if [ $? -eq 0 ]; then 
            sed -i '63s/^/#/' /etc/fstab
            systemctl "$sysreload"
            echo "[Part 4 파일 언마운트 완료]"
            df -hT  | boxes -d boy
        fi
    else 
        echo "이미 언마운트된 디스크입니다."
    fi
}
     
# 1) 새 파티션 생성 및 존재 여부 체크
echo "[Part 1. 파티션 생성 및 조회 작업 ]"
diskCheckInfo

# 2. 파일 시스템 작업 진행
echo "[Part 2 파일 시스템 작업 ]"
xfsFormat
# 3. Mount /Umount 작업 진행
echo "[Part 3 파일 마운트 작업 진행]"
mountDiskProc
echo



