#########################################################################
# File Name: SysInfo.sh
# Author:
# mail: 
# Created Time: 2020年04月19日 星期日 22时33分12秒
#########################################################################
#!/bin/bash


#时间 主机名 OS版本 内核版本 运行时间 平均负载 磁盘总量 磁盘已用% 内存大小 内存已用% CPU温度 磁盘报警级别 内存报警级别 CPU报警级别


echo -n `date "+%Y-%m-%d__%H:%M:%S"`

echo -n " " `uname -n`
echo -n " " `uname -v`
echo -n " " `uname -r`

echo -n "up" `uptime | awk -F "up" '{print $2}' | awk -F "," '{print $1}'`
echo -n `uptime | awk -F ":" '{print $4}'`

diskSum=`df -kl|awk '{print $2,$3}'|sed '1d'|awk '{sum += $1};END {print sum}'`
diskUse=`df -kl|awk '{print $2,$3}'|sed '1d'|awk '{sum += $2};END {print sum}'`
diskPcent=`expr $diskUse \* 100 / $diskSum`

echo -n " " $diskSum" "$diskPcent"%"

memSum=`free | awk 'NR==2 {print $2}'`
memUse=`free | awk 'NR==2 {print $3}'`
memPcent=`expr $memUse \* 100 / $memSum`

echo -n " "$memSum" "$memPcent"%"

tempout=`sensors | grep 'Core 0' | awk -F ": +" '{print $2}' | awk -F " " '{print $1}'`
temp=`sensors | grep 'Core 0' | awk -F ": +" '{print $2}' | awk -F "+" '{print $2}' | awk -F "." '{print $1}'`

echo -n " "$tempout

if [ $memPcent -le 80 ]; then
	echo -n " "normal" "
elif [ $memPcent -le 90 ]; then
	echo -n " "note" "
else 
	echo -n " "warning" "
fi

if [ $diskPcent -le 50 ]; then
	echo -n normal" "
elif [ $diskPcent -le 50 ]; then
	echo -n note" "
else
	echo -n warning" "
fi

if [ $temp -le 70 ]; then
	echo normal
elif [ $tem -le 80 ]; then
	echo note
else
	echo warning
fi
