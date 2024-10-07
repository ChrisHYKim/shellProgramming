#!/bin/bash

#
# (작업 절차)
# 1. 파티션 용량 (P1: 500M , P2 나머지 100%)
# 2. 파일 시스템 작업 (P1- XFS, P2-ext4)
# 3. 마운트 작업 (Mount (/databases))

# 1. disk.sh 디스크 1번을 새로 다시 지운 후, P1,P2 각각 생성한다.
diskFormat(){
        xfs_check=$(lsblk --fs /dev/sdb1 2>&1)
        # 디스크 존재 여부 체크 (sdb1 존재 여부를 찾습니다.)
        if lsblk | grep -q 'sdb1'  ; then
            sleep 1 ;   echo "d" >> /dev/null 2>&1
        fi
        sleep 1 ; echo "n" >> /dev/null 2>&1
        sleep 1 ; echo "p" >> /dev/null 2>&1  
        sleep 1 ; echo "1" >> /dev/null 2>&1
        sleep 1 ; echo ""  >> /dev/null 2>&1
        sleep 1 ; echo "+500MB" >> /dev/null 2>&1
        if echo "$xfs_check" | grep -q 'xfs'; then
            sleep 1 ; echo  'y' >> /dev/null 2>&1
        fi
        sleep 1 ; echo "n" >> /dev/null 2>&1
        sleep 1 ; echo "p" >> /dev/null 2>&1
        sleep 1 ; echo "2" >> /dev/null 2>&1
        sleep 1 ; echo ""  >> /dev/null 2>&1
        sleep 1 ; echo ""  >> /dev/null 2>&1
        sleep 1 ; echo "p" >> /dev/null 2>&1
        sleep 1 ; echo "w" >> /dev/null 2>&1
}
# 1. 디스크 상태 조회
diskCheck() {
    diskname=$(lsblk -no NAME /dev/sdb)
    if lsblk | grep -q 'sdb*'; then
        echo "fdisk 실행 $diskname  이미 생성되었습니다."
    else 
        diskFormat | fdisk /dev/sdb 2>&1 
        echo "=====result disk2====="
        echo "  디스크 파일 포맷 완료"
        echo "======================"
    fi
}
# 2.xfs -> ext4 (xfs -> ext4 (/dev/sdb1 파티션1))
xfsChecks(){
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
# 3.ext4 파일 시스템 포맷 생성
ext4FileSys() {
    ext4Sys=$(lsblk --fs /dev/sdb2 2>&1)
    if echo "$ext4Sys" | grep -q 'ext4'; then
        echo '[ OK ] 이미 EXT4 작업이 진행된 디스크입니다.'
    else 
        mkfs.ext4 "/dev/sdb2" >> /dev/null 2>&1
        echo "========Result========"
        echo "[success] ext4 파일 포맷"
    fi
}
# 3.마운트 작업 진행
diskProcMount() {
    mount_xfs_uuid=$(blkid "/dev/sdb1" | grep "UUID" | cut -d '"' -f 2)
    mount_ext4_uuid=$(blkid "/dev/sdb2"| grep "UUID" | cut -d '"' -f 2)
    mount_xfs_dir="$HOMEDIR/databases"
    mount_ext4_dir="$HOMEDIR/diskProc"
    sysreload=$(systemctl daemon-reload)
    if [  -d "$mount_xfs_dir"    ] &&  [  -d "$mount_ext4_dir"    ]; then
        echo "===== disk1 (/dev/sdb1) mount ======"
        mount "/dev/sdb1" "$mount_xfs_dir"
        echo "===== disk2 (/dev/sdb2) mount ======"
        mount "/dev/sdb2" "$mount_ext4_dir"
        if [ $? -eq 0 ]; then
            echo "두 디스크 모두 마운트 성공"

            if grep -q "$mount_xfs_dir" /etc/fstab && grep -q "$mount_ext4_dir" /etc/fstab; then
                sed -i '67s/^#//' /etc/fstab
                sed -i '72s/^#//' /etc/fstab
                $sysreload
                df -hT | boxes -d santa
            else 
                sed -i '$ 64,66s\#\n# (9) disk2.sh disk1 configuration\n#\nUUID='"$mount_xfs_uuid"' '"$mount_xfs_dir"' xfs defaults 0 2' /etc/fstab
                sed -i '$ 70,72\#\n# (10) disk2.sh disk2 configuration\n#\nUUID='"$mount_ext4_uuid"' '"$mount_ext4_dir"' ext4 defaults 0 2' /etc/fstab
                $sysreload
            fi
        fi
    else 

        mkdir -p $mount_xfs_dir
        echo "=========Success dir==========="
        echo "    ($mount_xfs_dir)          "
        echo "==============================="
    fi

    # 마운트 작업 해제 (xfs format)
    if mountpoint -q $mount_xfs_dir && mountpoint -q "$mount_ext4_dir"; then 
        umount "$mount_xfs_dir" 
        umount "$mount_ext4_dir"
        if [ $? -eq 0 ]; then
            sed -i '67s/^/#/' /etc/fstab 
            $sysreload
            sed -i '72s/^/#/' /etc/fstab 
            echo "[Part 4.마운트 해제 ]"
            df -hT | boxes -d santa
            echo
        fi
    fi
}



echo "[Part 1. 파티션 생성 작업 진행]"
diskCheck
echo "[Part 2-1. XFS 시스템 진행]"
xfsChecks
echo "[Part 2-2. EXT4 시스템 진행]"
ext4FileSys
echo "[Part 3.xfs,ext4 마운트 작업 진행]"
diskProcMount

