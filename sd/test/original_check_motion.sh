#!/bin/sh
# each minute, check for a new video file (which is created in case of motion detection)
# and if found, create the appropriate file for the http server

cd /home/hd1/record/
while [ 1 -eq 1 ] 
  do
    motion_file=$(find . -type f -name "*.mp4" -mmin -1 | tail -1)
    echo "M="$motion_file
    echo $motion_file | sed "s/.\//record\//" > /home/hd1/test/http/motion
    sleep 30
done
