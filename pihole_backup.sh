#!/bin/bash
mkdir /home/pi/pihole-$(date '+%F')
cd /home/pi/pihole-$(date '+%F')
pihole -a -t
sqlite3 /etc/pihole/pihole-FTL.db ".backup /home/pi/pihole-$(date '+%F')/pihole-FTL.db.backup"
tar -czvf /home/pi/pihole-$(date '+%F').tar.gz /home/pi/pihole-$(date '+%F') --remove-files
mv /home/pi/pihole-$(date '+%F').tar.gz /mnt/Backup/
find /mnt/Backup -name "pihole-*.tar.gz" -type f -mtime +7 -exec rm -f {} \;
