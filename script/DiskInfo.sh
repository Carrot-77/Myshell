#########################################################################
# File Name: DiskInfo.sh
# Author:
# mail: 
# Created Time: 2020年04月21日 星期二 09时49分29秒
#########################################################################
#!/bin/bash

#2018-01-12__16:48:23 标识（0为整个磁盘，1为分区） 磁盘还是分区（disk| /boot , /） 磁盘/分区总量 磁盘/分区剩余量 占用比例
echo -n `date "+%Y-%m-%d__%H:%M:%S"`" 1 "

echo -n `fdisk -l | awk -F " " 'NR==1 {print $2}' | awk -F "：" '{print $1}'`
total1=`fdisk -l | grep "Disk" | awk -F "：" 'NR==1 {print $2}' | awk -F " " '{print $1}'`
echo " "$total1"G"
#分区剩余 占用比例


echo -n `date "+%Y-%m-%d__%H:%M:%S"`" 1 "
echo -n `fdisk -l | grep "Disk" | awk -F "：" 'NR==2 {print $1}' | awk -F " " '{print $2}'`
total2=`fdisk -l | grep "Disk" | awk -F "：" 'NR==2 {print $2}' | awk -F " " '{print $1}'`
echo " "$total2"G"
#分区剩余 占用比例


echo -n `date "+%Y-%m-%d__%H:%M:%S"`" 0 disk "
diskSum=`df -kl|awk '{print $2,$3}'|sed '1d'|awk '{sum += $1};END {print sum}'`
diskUse=`df -kl|awk '{print $2,$3}'|sed '1d'|awk '{sum += $2};END {print sum}'`
diskPcent=`expr $diskUse \* 100 / $diskSum`
echo -n $diskSum" "
diskFree=`echo "$diskSum - $diskUse" | bc`
echo $diskFree" "$diskPcent"%"
