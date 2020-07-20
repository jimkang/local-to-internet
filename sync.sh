#!/bin/bash

s3cmd=/usr/local/bin/s3cmd
localparentdir=$1
bucket=$2
bucketdir=$3

synclog=/var/log/local-to-internet/sync.log
errorlog=/var/log/local-to-internet/error.log

if [[ ! $localparentdir ]] || [[ ! $bucket ]] || [[ ! $bucketdir ]]; then
  printf "Usage: ./sync-to-internet.sh <directory path on server that has directories to be synced, e.g. /usr/share/nginx/html> <bucket name> <bucket directory>\n\nThis script depends on the s3cmd auth already having been done.";
  exit 1;
fi

echo "--START--" >> "${synclog}"
echo "--START--" >> "${errorlog}"
date >> "${synclog}"
date >> "${errorlog}"
"${s3cmd}" sync --acl-public --delete-after "${localparentdir}" "s3://${bucket}/${bucketdir}" >> "${synclog}" 2>> "${errorlog}"
echo "--END--" >> "${synclog}"
echo "--END--" >> "${errorlog}"
