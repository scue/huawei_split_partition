echo off
echo "=== spliting .."
adb wait-for-device && adb reboot recovery
adb wait-for-device && adb push busybox /busybox
adb wait-for-device && adb push split_part.sh /split_part.sh
adb wait-for-device && adb push e2fsck_s /e2fsck_s
adb wait-for-device && adb push resize2fs_s /resize2fs_s
adb wait-for-device && adb shell chmod 755 /busybox
adb wait-for-device && adb shell chmod 755 /split_part.sh
adb wait-for-device && adb shell chmod 755 /e2fsck_s
adb wait-for-device && adb shell chmod 755 /resize2fs_s
adb wait-for-device && adb shell /split_part.sh
echo "=== all done"
adb wait-for-device && adb reboot
@pause
