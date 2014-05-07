echo off
echo "=== spliting .."
adb wait-for-device && adb reboot recovery
adb wait-for-device && adb push busybox /tmp/busybox
adb wait-for-device && adb push split_part.sh /tmp/split_part.sh
adb wait-for-device && adb shell chmod 755 /tmp/busybox
adb wait-for-device && adb shell chmod 755 /tmp/split_part.sh
adb wait-for-device && adb shell /tmp/split_part.sh
echo "=== formating .."
adb wait-for-device && adb reboot recovery
adb wait-for-device && adb push busybox /tmp/busybox
adb wait-for-device && adb push format_part.sh /tmp/format_part.sh
adb wait-for-device && adb shell chmod 755 /tmp/busybox
adb wait-for-device && adb shell chmod 755 /tmp/format_part.sh
adb wait-for-device && adb shell /tmp/format_part.sh
echo "=== all done"
adb wait-for-device && adb reboot
@pause
