#!/bin/bash
if [ -f /tmp/list-box ] ; then truncate -s 0 /tmp/list-box ;fi &&
while read -r trg; do
    echo $trg >> /tmp/list-box 2> /dev/null
done
sed -i '/bin/!d' /tmp/list-box &&
sed -i '/share/d' /tmp/list-box &&
cp /tmp/list-box /var/log/distrobox-path.log &&
printf "\n------------------------------\nrun distrobox-import now\n------------------------------"
