#########################################################################
# File Name: User.sh
# Author:
# mail: 
# Created Time: 2020年04月18日 星期六 16时29分09秒
#########################################################################
#!/bin/bash

echo -n `date "+%Y-%m-%d__%H:%M:%S"`
userNum=`cat /etc/passwd | grep -v nologin | grep -v halt | grep -v shutdown | wc -l`

recUserNum=`last | awk -F ' ' '{print $1}' | head -n -2 | sort -u | wc -l`

recUser1=`last | awk -F ' ' '{print $1}' | head -n -2 | sort -u | awk 'NR==1 {print $0}'`
recUser2=`last | awk -F ' ' '{print $1}' | head -n -2 | sort -u | awk 'NR==2 {print $0}'`
recUser3=`last | awk -F ' ' '{print $1}' | head -n -2 | sort -u | awk 'NR==3 {print $0}'`

rootUser=`grep 'x:0:' /etc/passwd | awk -F ':' '{print $1}'`

nowUserNum=`w | awk -F ' ' '{print $1}' | wc -l`
nowUserNum=`expr $nowUserNum - 2 | bc`

nowUser=`w | awk -F ' ' '{print $1}' | tail -n +3`
nowTty=`w | awk -F ' ' '{print $2}' | tail -n +3`

echo -n $userNum 
echo -n [$recUser1] [$recUser2] [$recUser3] 
echo -n [$rootUser]


for i in $nowUser; do
	echo -n [$nowUser"_"$nowTty]
done
