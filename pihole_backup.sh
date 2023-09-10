#!/bin/bash
# mkdir /home/pi/pihole-$(date '+%F')
# cd /home/pi/pihole-$(date '+%F')
# pihole -a -t
# sqlite3 /etc/pihole/pihole-FTL.db ".backup /home/pi/pihole-$(date '+%F')/pihole-FTL.db.backup"
# tar -czvf /home/pi/pihole-$(date '+%F').tar.gz /home/pi/pihole-$(date '+%F') --remove-files
# mv /home/pi/pihole-$(date '+%F').tar.gz /mnt/Backup/
# find /mnt/Backup -name "pihole-*.tar.gz" -type f -mtime +7 -exec rm -f {} \;

# v2 work remotely. Consumes more bandwidth, but avoids needing extra local storage.

# NFS mount goes stale and needs to be remounted. Doing this before each backup to ensure mount is available.
sudo umount -f /mnt/Backup
sudo mount /mnt/Backup

mkdir /mnt/Backup/pihole-$(date '+%F')
cd /mnt/Backup/pihole-$(date '+%F')
pihole -a -t
sqlite3 /etc/pihole/pihole-FTL.db ".backup /mnt/Backup/pihole-$(date '+%F')/pihole-FTL.db.backup"
# tar -czvf /mnt/Backup/pihole-$(date '+%F').tar.gz /mnt/Backup/pihole-$(date '+%F') --remove-files
tar -czvf /mnt/Backup/pihole-$(date '+%F').tar.gz /mnt/Backup/pihole-$(date '+%F')
rm -rf /mnt/Backup/pihole-$(date '+%F') 2&>/dev/null
rm -rf /mnt/Backup/pihole-$(date '+%F')
# mv /home/pi/pihole-$(date '+%F').tar.gz /mnt/Backup/
find /mnt/Backup -name "pihole-*.tar.gz" -type f -mtime +7 -exec rm -f {} \;
