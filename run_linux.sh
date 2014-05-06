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

run(){
    adb wait-for-device && adb reboot recovery
    adb wait-for-device && adb push busybox /tmp/busybox
    adb wait-for-device && adb push split_part.sh /tmp/split_part.sh
    adb wait-for-device && adb shell chmod 755 /tmp/busybox
    adb wait-for-device && adb shell chmod 755 /tmp/split_part.sh
    adb wait-for-device && adb shell /tmp/split_part.sh
}

device=$(adb devices | grep device$ ||\
    adb devices | grep recovery$)

if [[ -z $device ]]; then
    echo "==> 没找到 Android 设备"
else
    run && run
    adb reboot
fi
