#!/bin/bash
if [ -f /tmp/list-box ] ; then truncate -s 0 /tmp/list-box ;fi &&
while read -r trg; do
    echo $trg >> /tmp/list-box 2> /dev/null
done
sed -i '/bin/!d' /tmp/list-box &&
sed -i '/share/d' /tmp/list-box &&
sed -i '/lib/d' /tmp/list-box &&
sed -i '/include/d' /tmp/list-box &&
mkdir -p /var/log/distrobox-import/
printf "#-delete lines to not export\n" > /var/log/distrobox-import/distrobox-path.log &&
cat /tmp/list-box >> /var/log/distrobox-import/distrobox-path.log &&
printf "\n------------------------------\nrun distrobox-import now\n------------------------------%s\n"
