华为U8825d、U8950d重新分区
========
　　针对DATA空间过小的手机重新分区，以获取更大的空间以安装应用程序，重新分区后，
默认Data空间大小是512Mb（可在split_part.sh修改），其余空间则自动分配给内置SD卡。

相关变量
========
*   **1.data_size**

    设置数据空间大小为512M，可修改为其他值

        data_size=512M

*   **2. cylinders_of_M**
    
    每Mb所占的磁柱数，一般情况下不能修改

        cylinders_of_M=122.0703125

操作步骤
========
*   **1. 分区操作**

        adb reboot recovery
        adb push busybox /tmp/busybox
        adb push split_part.sh /tmp/split_part.sh
        adb shell chmod 755 /tmp/busybox
        adb shell chmod 755 /tmp/split_part.sh
        adb shell /tmp/split_part.sh

*   **2. 格式化操作**

        adb reboot recovery
        adb push busybox /tmp/busybox
        adb push format_part.sh /tmp/format_part.sh
        adb shell chmod 755 /tmp/busybox
        adb shell chmod 755 /tmp/format_part.sh
        adb shell /tmp/format_part.sh

*   **3. 重启手机**

        adb reboot

自动操作
========
*   **运行脚本**

        ./run_linux.sh
