#!/bin/sh
# each minute, check for a new video file (which is created in case of motion detection)
# and if found, create the appropriate file for the http server

API_TOKEN='API Token'

CHAT_ID_1='Chat ID'
CHAT_ID_2='Chat ID'
DIR=/home/hd1/record/

cd /home/hd1/record/
old_motion_file=1
new_motion_file=1

while [ 1 -eq 1 ] 
  do
    motion_file=$(find . -type f -name "*.mp4" -mmin -1 | tail -1)
    echo $motion_file | sed "s/.\//record\//" > /home/hd1/test/http/motion

send_motion_file=$(echo $motion_file  | sed "s/.\//\/home\/hd1\/record\//")

if [[ "$motion_file" = "$old_motion_file" ]];  then
	echo "math"
##	
	else 
	echo "Not match"
	
	## Send text to users
	#/home/curl --insecure --data "chat_id=$CHAT_ID_1&text=Moving detection" https://api.telegram.org/bot$API_TOKEN/sendMessage > /dev/null
	#/home/curl --insecure --data "chat_id=$CHAT_ID_2&text=Moving detection" https://api.telegram.org/bot$API_TOKEN/sendMessage > /dev/null
	
	## Send Video to users
	/home/curl --insecure  -F document=@$send_motion_file  https://api.telegram.org/bot$API_TOKEN/sendDocument?chat_id=$CHAT_ID_1 > /dev/null
	/home/curl --insecure  -F document=@$send_motion_file  https://api.telegram.org/bot$API_TOKEN/sendDocument?chat_id=$CHAT_ID_2 > /dev/null
		
	old_motion_file=$motion_file;
fi
    sleep 5
done