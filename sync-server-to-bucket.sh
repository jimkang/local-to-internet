#!/bin/bash

s3cmd=/usr/local/bin/s3cmd
localparentdir=$1
bucket=$2
bucketdir=$3

remotedest="s3://${bucket}/${bucketdir}/"
synclog=/var/log/local-to-internet/sync-bucket.log
errorlog=/var/log/local-to-internet/error-bucket.log

if [[ ! $localparentdir ]] || [[ ! $bucket ]] || [[ ! $bucketdir ]]; then
  printf "Usage: ./sync-server-to-bucket <directory path on server to be synced, e.g. /usr/share/nginx/html> <bucket name> <bucket directory>\n\nThis script depends on the s3cmd auth already having been done.";
  exit 1;
fi

echo "--START--" >> "${synclog}"
echo "--START--" >> "${errorlog}"
date >> "${synclog}"
date >> "${errorlog}"

"${s3cmd}" sync --acl-public --exclude-from .s3ignore "${localparentdir}" "${remotedest}" >> "${synclog}" 2>> "${errorlog}"

echo "--END--" >> "${synclog}"
echo "--END--" >> "${errorlog}"
