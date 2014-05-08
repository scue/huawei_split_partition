echo off
echo "=== spliting .."
adb wait-for-device && adb reboot recovery
adb wait-for-device && adb push busybox /busybox
adb wait-for-device && adb push split_part.sh /split_part.sh
adb wait-for-device && adb shell chmod 755 /busybox
adb wait-for-device && adb shell chmod 755 /split_part.sh
adb wait-for-device && adb shell /split_part.sh
echo "=== formating .."
adb wait-for-device && adb reboot recovery
adb wait-for-device && adb push busybox /busybox
adb wait-for-device && adb push format_part.sh /format_part.sh
adb wait-for-device && adb shell chmod 755 /busybox
adb wait-for-device && adb shell chmod 755 /format_part.sh
adb wait-for-device && adb shell /format_part.sh
echo "=== all done"
adb wait-for-device && adb reboot
@pause
