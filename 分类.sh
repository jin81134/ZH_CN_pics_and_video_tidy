#!bin/bash
#2020.08.28上传
#此脚本仅用于分类
#Linux下可以使用如下命令下载
#git clone 'https://github.com/811343804/ZH_CN_pics_and_video_tidy'
read -p "所需处理目录：" A 
read -p "所需处理的起始年（例如2020）：" B
read -p "所需处理的终止年（例如2020）：" E
C=1	#月份变量
if [ $B -gt 0 ] && [ $E -gt 0 ]
then
	echo 执行中。。。
else
	echo 错误！（$B）（$E） 其中不是纯数字！！
	exit
fi
if [ $B -gt $E ] #判断数字B是否大于E
then	
	echo 错误！ 起始年（$B）不能大于终止年（$E）！！
exit
fi
until [ $B \> $E ] #直到B大于E时停止
do
	if [ -d $A ]
	then
		cd $A
		mkdir -p 照片 视频 未知
		mv -u `ls -a|grep ".jpg"` $A/照片
		mv -u `ls -a|grep ".mp4"` $A/视频
		mv -u `ls -a|egrep -v "(年|照片|视频|未知)"` $A/未知
		until [ $C -gt 12 ] #直到C大于12时停止
		do
			mkdir -p $A/$B年/$C月/照片
			mkdir -p $A/$B年/$C月/视频
			if [ $C -le 9 ] #小于或等于9
			then
				cd $A/照片
				mv -u `ls -a|grep "${B}0${C}"` $A/$B年/$C月/照片
				cd $A/视频
				mv -u `ls -a|grep "${B}0${C}"` $A/$B年/$C月/视频
			else
				cd $A/照片
				mv -u `ls -a |grep "${B}${C}"` $A/$B年/$C月/照片
				cd $A/视频
				mv -u `ls -a|grep "${B}${C}"` $A/$B年/$C月/视频
			fi
			C=$(($C+1))
		done
		echo $B年完成!
	else 
		echo  文件夹$A不存在! 
	fi
C=1
B=$(($B+1))
done
#测试使用#####################################################################
D=0
while [ $D = 0 ]
do
	read -p "是否删除$A下的所有文件？(y/n)" D
	if	[ $D = Y -o $D = y ]
	then
		rm -r $A/*
	elif	[ $D = N -o  $D = n ]
	then	
		echo 未删除$A下的文件！
	else
		D=0
		echo 输入错误请重新输入！
	fi
done
