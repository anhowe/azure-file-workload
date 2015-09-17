#!/bin/bash

echo "starting generation"

if [ $# -ne 2 ]
then
 echo "you must pass storage account name followed by storage account key"
 exit 1
fi

ACCOUNT=$1
ACCOUNTKEY=$2
mkdir -p /mnt/data-a
mount -t cifs //${ACCOUNT}.file.core.windows.net/data-a /mnt/data-a -o vers=2.1,username=${ACCOUNT},password=${ACCOUNTKEY}
if [ $? -ne 0 ]
then
 echo "unable to mount share"
 exit 1
fi

MOUNTSHARE=/mnt/data-a

for i in {1..10}; do
 PATH1=`cat /dev/urandom| tr -dc 'a-z'|head -c 1`
 PATH2=`cat /dev/urandom| tr -dc 'a-z'|head -c 1`
 FILE=`cat /dev/urandom| tr -dc 'a-z'|head -c 1`
 DIRPATH=${MOUNTSHARE}/${PATH1}/${PATH2}
 mkdir -p $DIRPATH
 FULLPATH=${MOUNTSHARE}/${PATH1}/${PATH2}/$FILE
 echo $FULLPATH
 head -c 1M < /dev/urandom >> $FULLPATH
 ls -l $FULLPATH
done
