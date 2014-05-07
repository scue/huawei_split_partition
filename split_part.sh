#!/sbin/sh
#===============================================================================
#
#          FILE: splite_part.sh
# 
#         USAGE: /tmp/splite_part.sh 
# 
#   DESCRIPTION:对华为U8825D和华为U8950d重新分区操作，默认Data大小是512M 
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
data_size=512M

# 每兆磁柱
cylinders_of_M=122.0703125

# busybox
busybox=/tmp/busybox

# 相关计算
p18_start=$($busybox fdisk -l /dev/block/mmcblk0 |\
    $busybox tail -n2 |\
    $busybox head -n1 |\
    awk '{print $2}')
p19_start=$($busybox awk -va=$cylinders_of_M -vb=$p18_start \
    'BEGIN {print a*512+b+2}')
p19_end=$($busybox fdisk -l /dev/block/mmcblk0 |\
    $busybox tail -n1 |\
    $busybox awk '{print $3}')

# 危险操作
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

w

EOF
