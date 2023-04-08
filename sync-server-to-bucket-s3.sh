#!/bin/bash

localparentdir=$1
dest=$2

remotedest="s3://${dest}/"
synclog=/var/log/local-to-internet/sync-s3-bucket.log
errorlog=/var/log/local-to-internet/error-s3-bucket.log

if [[ ! $localparentdir ]] || [[ ! $dest ]]; then
  printf "Usage: ./sync-server-to-bucket <directory path on server to be synced, e.g. /usr/share/nginx/html> <s3 uri>\n\nThis script depends on the aws auth already having been done.";
  exit 1;
fi

echo "--START--" >> "${synclog}"
echo "--START--" >> "${errorlog}"
date >> "${synclog}"
date >> "${errorlog}"

/usr/local/bin/aws s3 sync --exclude .s3ignore "${localparentdir}" "${dest}" >> "${synclog}" 2>> "${errorlog}"

echo "--END--" >> "${synclog}"
echo "--END--" >> "${errorlog}"
