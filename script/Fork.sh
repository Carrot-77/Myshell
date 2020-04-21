#########################################################################
# File Name: ProcessMonitor.sh
# Author:
# mail: 
# Created Time: 2020年04月17日 星期五 12时02分02秒
#########################################################################
#!/bin/bash

memName=$(ps -eo %mem,command | sort -nr -k1 | head -n 1 | awk '{print $2}')
memUse=$(ps -eo %mem | sort -nr -k1 | head -n 1 | awk '{print $1}')
memPid=$(ps -eo %mem,pid | sort -nr -k1 | head -n 1 | awk '{print $2}')
memUser=$(ps -eo %mem,user | sort -nr -k1 | head -n 1 | awk '{print $2}')
memCpu=$(ps -eo %mem,%cpu | sort -nr -k1 | head -n 1 | awk '{print $2}')

cpuName=$(ps -eo %cpu,command | sort -nr -k1 | head -n 1 | awk '{print $2}')
cpuUse=$(ps -eo %cpu | sort -nr -k1 | head -n 1 | awk '{print $1}')
cpuPid=$(ps -eo %cpu,pid | sort -nr -k1 | head -n 1 | awk '{print $2}')
cpuUser=$(ps -eo %mem,user | sort -nr -k1 | head -n 1 | awk '{print $2}')
cpuMem=$(ps -eo %mem,%mem | sort -nr -k1 | head -n 1 | awk '{print $2}')

stu=50


if [ `echo "$memUse > $stu" | bc` -eq 1 ]; then
	echo memUse $memUse
	/bin/sleep 5
	memUse=$(ps -eo %mem,pid | eval grep $memPid | awk '{print $1}')
	if [ `echo "$memUse > $stu" | bc` -eq 1 ]; then
		echo -n `date "+%Y-%m-%d__%H:%M:%S"`
		echo "$memName $memPid $memUser $memCpu% $memUse%"
	fi
elif [ `echo "$cpuUse > $stu" | bc` -eq 1 ]; then
	echo cpuUse $cpuUse
	/bin/sleep 5
	cpuUse=$(ps -eo %cpu,pid | eval grep $cpuPid | awk '{print $1}')
	if [ `echo "$cpuUse \> $stu" | bc` -eq 1 ]; then
		echo -n `date "+%Y-%m-%d__%H:%M:%S"`
		echo "$cpuName $cpuPid $cpuUser $cpuUse% $cpuMem%"
	fi
else
	echo no
fi


