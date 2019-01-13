Change Debian Hostname with no restart

You first need to add the sam name in the /etc/hosts

sudo hostnamectl set-hostname YOUR_NAME

Log out, log in and it is done