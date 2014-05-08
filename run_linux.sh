#!/bin/bash - 
#===============================================================================
#
#          FILE: run_linux.sh
# 
#         USAGE: ./run_linux.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: linkscue (scue), linkscue@gmail.com
#  ORGANIZATION: 
#       CREATED: 2014年05月06日 20时04分08秒 CST
#      REVISION:  ---
#===============================================================================

split(){
    echo "==> spliting .."
    ./adb wait-for-device && ./adb reboot recovery
    ./adb wait-for-device && ./adb push busybox /busybox
    ./adb wait-for-device && ./adb push e2fsck_s /e2fsck_s
    ./adb wait-for-device && ./adb push resize2fs_s /resize2fs_s
    ./adb wait-for-device && ./adb push split_part.sh /split_part.sh
    ./adb wait-for-device && ./adb shell chmod 755 /busybox
    ./adb wait-for-device && ./adb shell chmod 755 /split_part.sh
    ./adb wait-for-device && ./adb shell chmod 755 /e2fsck_s
    ./adb wait-for-device && ./adb shell chmod 755 /resize2fs_s
    ./adb wait-for-device && ./adb shell /split_part.sh
}

device=$(./adb devices | grep device$ ||\
    ./adb devices | grep recovery$)

if [[ -z $device ]]; then
    echo "==> 没找到 Android 设备"
else
    split
    ./adb reboot
fi
