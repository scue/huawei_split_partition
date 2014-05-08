华为U8825d、U8950d重新分区
========
　　针对DATA空间过小的手机重新分区，以获取更大的空间以安装应用程序，重新分区后，
默认Data空间大小是1536Mb（可在split_part.sh修改），其余空间则自动分配给内置SD卡。

　　即使手机之前使用了别人的教程，分区失败了，一样可以修复错误18、19分区。

　　分区完成前后，手机Data数据空间内容不丢失，原有安装的软件依然存在，稍有遗憾的
如果是增大Data数据空间，内置SD卡在分区之后可能不可用，需要手动格式化。

![screenshot.gif](https://github.com/scue/huawei_split_partition/raw/shots/shots/windows.gif)

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

　　请确保已连接手机到电脑，并已有相应的驱动程序，同时要求手机已ROOT和安装第三方
Recovery。

*   **Linux**

        ./run_linux.sh

*   **Windows**

    +   请连接手机，并打开USB调试
    +   通过手机助手这类软件安装好驱动
    +   运行 run_windows.bat，手机会自动进入recovery模式
    +   手机在recovery模式，可在 计算机 -- 管理 -- 设备管理器 中找到“Android Phone”
    +   如果设备管理器没能到“Android Phone”，则需要再安装驱动
    +   确保recovery模式的手机已被正确识别之后，按下任意键，让run_windows.bat继续运行
    +   完美分区后手机会自动重启（分区结束后长时间不能重启是recovery的bug，手动重启即可）

        run_windows.bat
