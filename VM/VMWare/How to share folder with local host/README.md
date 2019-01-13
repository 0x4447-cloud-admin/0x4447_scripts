# How to share a folder with the host system on VMWare.

- mount /dev/cdrom /mnt/cdrom
- cd /tmp
- rpm -Uhv /mnt/cdrom/VMwareTools-5.0.0-<xxxx>.i386.rpm
- umount /dev/cdrom
- cd vmware-folder
- sudo vmware-config-tools.pl
- answer all yes
- stop the machine
- mount the folder you want to share in the settings
- start the machine
- check if you have the /mnt/hgfs
- if not make sudo mkdir /mnt/hgfs
- then run `sudo /usr/bin/vmhgfs-fuse .host:/ /mnt/hgfs -o subtype=vmhgfs-fuse,allow_other`
- symbolic link to destination `ln -s /mnt/hgfs/GitHub/Documents`


