#!/bin/bash - 
#===============================================================================
#
#          FILE: format_part.sh
# 
#         USAGE: ./format_part.sh 
# 
#   DESCRIPTION: 分区结束后格式化分区
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: linkscue (scue), linkscue@gmail.com
#  ORGANIZATION: 
#       CREATED: 2014年05月07日 13时26分43秒 CST
#      REVISION:  ---
#===============================================================================

busybox=/tmp/busybox

# 格式化
#-------------------------------------------------------------------------------
#  可能需要重启 recovery 后才可以正确格式化，出现如下错误：
#      mke2fs: lseek: Value too large for defined data type
#  表示 fdisk 分区还未生效，格式化 EXT4 时出现了错误，此时应当重启到 recovery
#  重新执行再一次执行此脚本
#-------------------------------------------------------------------------------
$busybox mke2fs -T ext4 -L data /dev/block/mmcblk0p18
$busybox mkdosfs -v -n huawei /dev/block/mmcblk0p19
