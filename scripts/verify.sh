#!/bin/bash
#set -x

total=0
status=1
#sleep 2
while [ $status -ne 0 ];
do
  curl -H "Accept:text/plain" --silent --show-error --connect-timeout 1 $1 | grep -q 'status'
  [ $? -eq 0 ] && status=0
  sleep 5
  total=`expr $total + 5`
  echo 'Service is still not up...!!!'
  if [ $total -gt 120 ]
  then
      echo '\*** Service is still not up ! Waited for 2 mins. Please check manually! ****\'
    exit 1
  fi
done
echo "Service is Up..!!!"
exit 0
