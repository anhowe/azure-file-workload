#!/bin/bash

echo "starting generation"

if [ $# -ne 3 ]
then
 echo "you must pass arguments STORAGEACCOUNT STORAGEACCOUNTKEY SHARE"
 exit 1
fi

ACCOUNT=$1
ACCOUNTKEY=$2
SHARE=$3
MOUNTSHARE=/mnt/${SHARE}
mkdir -p /mnt/$SHARE
mount -t cifs //${ACCOUNT}.file.core.windows.net/${SHARE} ${MOUNTSHARE} -o vers=2.1,username=${ACCOUNT},password=${ACCOUNTKEY}
if [ $? -ne 0 ]
then
 echo "unable to mount share"
 exit 1
fi


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
