#!/bin/bash
# mkdir /home/pi/pihole-$(date '+%F')
# cd /home/pi/pihole-$(date '+%F')
# pihole -a -t
# sqlite3 /etc/pihole/pihole-FTL.db ".backup /home/pi/pihole-$(date '+%F')/pihole-FTL.db.backup"
# tar -czvf /home/pi/pihole-$(date '+%F').tar.gz /home/pi/pihole-$(date '+%F') --remove-files
# mv /home/pi/pihole-$(date '+%F').tar.gz /mnt/Backup/
# find /mnt/Backup -name "pihole-*.tar.gz" -type f -mtime +7 -exec rm -f {} \;

# v2 
# Do all work remotely. 
# Consumes more bandwidth and takes longer, but avoids needing extra local storage.
mkdir /mnt/Backup/pihole-$(date '+%F')
cd /mnt/Backup/pihole-$(date '+%F')
pihole -a -t
sqlite3 /etc/pihole/pihole-FTL.db ".backup /mnt/Backup/pihole-$(date '+%F')/pihole-FTL.db.backup"
tar -czvf /mnt/Backup/pihole-$(date '+%F').tar.gz /mnt/Backup/pihole-$(date '+%F') --remove-files
# mv /home/pi/pihole-$(date '+%F').tar.gz /mnt/Backup/
find /mnt/Backup -name "pihole-*.tar.gz" -type f -mtime +7 -exec rm -f {} \;
