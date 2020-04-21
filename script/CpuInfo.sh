#########################################################################
# File Name: CpuInfo.sh
# Author:
# mail: 
# Created Time: 2020年04月20日 星期一 19时51分10秒
#########################################################################
#!/bin/bash

echo -n `date "+%Y-%m-%d__%H:%M:%S"`
echo -n `cat /proc/loadavg | awk -F " " '{print $1,$2,$3}'`

cpu1[0]=`cat /proc/stat | awk 'NR==2 {print $2}'`
cpu1[1]=`cat /proc/stat | awk 'NR==2 {print $3}'`
cpu1[2]=`cat /proc/stat | awk 'NR==2 {print $4}'`
cpu1[3]=`cat /proc/stat | awk 'NR==2 {print $5}'`
cpu1[4]=`cat /proc/stat | awk 'NR==2 {print $6}'`
cpu1[5]=`cat /proc/stat | awk 'NR==2 {print $7}'`
cpu1[6]=`cat /proc/stat | awk 'NR==2 {print $8}'`

for ((i=0;i<7;i++)); do
	sum1=`expr $sum1 + ${cpu1[$i]}`
done

cpu2[0]=`cat /proc/stat | awk 'NR==3 {print $2}'`
cpu2[1]=`cat /proc/stat | awk 'NR==3 {print $3}'`
cpu2[2]=`cat /proc/stat | awk 'NR==3 {print $4}'`
cpu2[3]=`cat /proc/stat | awk 'NR==3 {print $5}'`
cpu2[4]=`cat /proc/stat | awk 'NR==3 {print $6}'`
cpu2[5]=`cat /proc/stat | awk 'NR==3 {print $7}'`
cpu2[6]=`cat /proc/stat | awk 'NR==3 {print $8}'`

for ((i=0;i<7;i++)); do
	sum2=`expr $sum2 + ${cpu2[$i]}`
done

useTime=`expr ${cpu2[3]} - ${cpu1[3]}`
usePecent=$(echo "1 - $useTime / ($sum2 - $sum1)"| bc)
echo -n $usePecent" "

temp=`echo $[$(cat /sys/class/thermal/thermal_zone0/temp) / 1000 | bc]`
echo -n $temp"° "

if [ $temp -le 50 ]; then
	echo normal
elif [ $temp -le 70 ]; then
	echo note
else echo warning
fi

