#!/bin/bash

# This is the complement to sync-subdir-at-a-time.sh.

s3cmd=/usr/local/bin/s3cmd
localdir=$1
bucket=$2
bucketdir=$3

remotedest="s3://${bucket}/${bucketdir}"
synclog=/var/log/local-to-internet/sync-internet-to-local.log
errorlog=/var/log/local-to-internet/error-internet-to-local.log

if [[ ! $localdir ]] || [[ ! $bucket ]] || [[ ! $bucketdir ]]; then
  printf "Usage: ./local-to-internet <directory path on server that should contain the backup directory, e.g. /usr/share/nginx/html/podcasts> <bucket name> <bucket directory>\n\nThis script depends on the s3cmd auth already having been done.";
  exit 1;
fi

echo "--START--" >> "${synclog}"
echo "--START--" >> "${errorlog}"
"${s3cmd}" sync --delete-after --exclude '.git/' "${remotedest}" "${localdir}" >> "${synclog}" 2>> "${errorlog}"
date >> "${synclog}"
date >> "${errorlog}"
echo "--END--" >> "${synclog}"
echo "--END--" >> "${errorlog}"
