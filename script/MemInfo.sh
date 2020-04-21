#########################################################################
# File Name: MemInfo.sh
# Author:
# mail: 
# Created Time: 2020年04月20日 星期一 23时38分05秒
#########################################################################
#!/bin/bash

#时间 总量 剩余量 当前占用（%）占用百分比动态平均值
#动态平均值=0.3动态平均值（上一次）+0.7当前占用比

echo -n `date "+%Y-%m-%d__%H:%M:%S"`

total=`free -h | awk 'NR==2 {print $2}' | awk -F "G" '{print $1}'`
use=`free -h | awk 'NR==2 {print $3}' | awk -F "G" '{print $1}'`
residue=`echo "$total - $use" | bc`
echo -n " "$total"G "$residue"G "

index=$(echo "scale=3; $use * 100" | bc)
memPecent=`echo "scale=2; $index / $total" | bc`
echo -n $memPecent"% "

nowPecent=`echo "scale=2; $memPecent * 0.7" | bc`
ans=`echo "scale=2; $nowPecent + 0.3 * $1" | bc`
echo $ans"%"
