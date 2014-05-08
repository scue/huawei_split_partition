echo off
echo "=== 正在执行分区 .."
.\adb reboot recovery
echo "=== 请等待手机重启至Recovery，然后按下任意键"
@pause
.\adb push busybox /busybox
.\adb push split_part.sh /split_part.sh
.\adb push e2fsck_s /e2fsck_s
.\adb push resize2fs_s /resize2fs_s
.\adb shell chmod 755 /busybox
.\adb shell chmod 755 /split_part.sh
.\adb shell chmod 755 /e2fsck_s
.\adb shell chmod 755 /resize2fs_s
.\adb shell /split_part.sh
echo "=== 分区操作完成"
.\adb reboot
@pause
