#!/bin/bash

localparentdir=$1
bucket=$2
bucketdir=$3

remotedest="s3://${bucket}/${bucketdir}/"
synclog=/var/log/local-to-internet/sync.log
errorlog=/var/log/local-to-internet/error.log

if [[ ! $localparentdir ]] || [[ ! $bucket ]] || [[ ! $bucketdir ]]; then
  printf "Usage: ./sync-subdir-at-a-time <directory path on server that contains subdirectories to be synced, e.g. /usr/share/nginx/html> <bucket name> <bucket directory>\n\nThis script depends on the s3cmd auth already having been done.";
  exit 1;
fi

for dir in $localparentdir/*/
do
    subdir=$(basename "$dir")
    ./sync.sh "${dir}" "${bucket}" "${bucketdir}/${subdir}"
    #echo "./sync.sh ${dir} ${bucket} ${bucketdir}/${subdir}"
done
