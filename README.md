# Backup pi-hole to NFS Share automatically via cron

## Get Destination NFS mount info

On the machine that is acting as your NFS server run the following to get a list of all NFS shares.  
You'll need this later when mounting the NFS share on the client.  
`exportfs -v`  

```bash
/mnt/user/Backup
                <world>(rw,async,wdelay,hide,no_subtree_check,fsid=102,anonuid=9                                             9,anongid=100,sec=sys,insecure,root_squash,all_squash)
```  

## Mount nfs share

First we need to create a mount point for the share.  
`sudo mkdir /mnt/Backup`  

## Manually

Test manually mounting the NFS share before adding to /etc/fstab  
`sudo mount -t nfs 192.168.1.10:/mnt/user/Backup/pihole /mnt/Backup/`  

If that works you should be able to `cd /mnt/Backup/` and **touch** a file.  
`cd /mnt/Backup && touch test.txt && ls -l`  

Remove the **test.txt** file we won't need for anything else.  
It was only created to verify write access to the NFS share.  
`rm -f /mnt/Backup/test.txt`  

## Automatically with /etc/fstab  
`sudo vi /etc/fstab`  

    192.168.1.10:/mnt/user/Backup/pihole    /mnt/Backup/     nfs    defaults    0    0  

**If you didn't manually mount the share in the previous section you need to do that now or reboot.**  
The mount command will read the contents of **/etc/fstab** and mount the share.  
`sudo mount /mnt/Backup`  

## Backup Script (~/pihole_backup.sh)  

`vi ~/pihole_backup.sh`  

pihole_backup.sh contents

	#!/bin/bash
	sudo systemctl stop pihole-FTL lighttpd
	tar -czvf /mnt/Backup/pihole-$(date '+%F').tar.gz ~/pihole
	sudo systemctl start lighttpd pihole-FTL
	find /mnt/Backup -name "pihole-*.tar.gz" -type f -mtime +7 -exec rm -f {} \;

`chmod u+x ~/pihole_backup.sh`  

## Add script to Cron

`crontab -e`  
0 5 * * * ~/pihole_backup.sh
