List all active User

- w command – Shows information about the users currently on the machine, and their processes.
- who command – Shows information about users who are currently logged in.
- users command – Shows the login names of the users currently on the system, in sorted order, space separated, on a single line. It reads all information from /var/run/utmp file.

# Kill idle user session

sudo pkill -9 -u USER_NAME


Managing users

To add a new user you can use:
sudo adduser USER_NAME

Add user to Sudoers Group
sudo usermod -aG sudo USER_NAME

To remove/delete a user, first you can use:
sudo deluser USER_NAME

Then you may want to delete the home directory for the deleted user account :
sudo rm -r /home/USER_NAME

To modify the USER_NAME of a user:
usermod -l new_username old_username

To change the password for a user:
sudo passwd USER_NAME

To change the shell for a user:
sudo chsh USER_NAME

To change the details for a user (for example real name):
sudo chfn USER_NAME
