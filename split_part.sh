#!/sbin/sh
#===============================================================================
#
#          FILE: splite_part.sh
# 
#         USAGE: /tmp/splite_part.sh 
# 
#   DESCRIPTION:对华为U8825D和华为U8950d重新分区操作，默认Data大小是1536M(1.5G)
#               需在recovery中操作，请上传 busybox 到 /tmp/busybox 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: linkscue (scue), linkscue@gmail.com
#  ORGANIZATION: 
#       CREATED: 2014年05月06日 18时46分56秒 CST
#      REVISION:  ---
#===============================================================================

# 数据空间
data_size=1536M

# 每兆磁柱
cylinders_of_M=122.0703125

# tools
busybox=/busybox
e2fsck=/e2fsck_s
resize2fs=/resize2fs_s

# 相关计算
p17_end=$($busybox fdisk /dev/block/mmcblk0 -l |\
    $busybox grep /dev/block/mmcblk0p17 |\
    $busybox awk '{print $3}')
p18_start=$($busybox awk -va=$p17_end 'BEGIN {print a+2}')
p19_start=$($busybox awk -va=$cylinders_of_M -vb=$p18_start -vs=$data_size \
    'BEGIN {print a*s+b+2}')
echo " -> /dev/block/mmcblk0p18 start from $p18_start"
echo " -> /dev/block/mmcblk0p19 start from $p19_start"

detect_18=$($busybox fdisk -l /dev/block/mmcblk0 |\
    $busybox grep /dev/block/mmcblk0p18)

# 危险操作
if [[ "$detect_18" == "" ]]; then
    $busybox fdisk /dev/block/mmcblk0 << EOF
n
$p18_start
+$data_size
n
$p19_start

t
19
c
w

EOF
    # 有损分区，修复已失败的分区
    echo " -> found missing partition 18 and 19, recreate and format they."
    $busybox mke2fs -T ext4 /dev/block/mmcblk0p18
    $busybox mkfs.vfat -v -n Huawei /dev/block/mmcblk0p19
else
    $busybox fdisk /dev/block/mmcblk0 << EOF
d
19
d
18
n
$p18_start
+$data_size
n
$p19_start

t
19
c
w

EOF
    # 无损分区
    p18_blocks=$($busybox fdisk /dev/block/mmcblk0 -l |\
        $busybox grep /dev/block/mmcblk0p18 |\
        $busybox awk '{print $4}')
    $e2fsck -f -y /dev/block/mmcblk0p18
    $resize2fs -f -F -M -p /dev/block/mmcblk0p18 $p18_blocks
    # 提示可能需要手动格式化内置SD卡
    echo " -> resize data ok, but you maybe format sdcard manually."
fi

