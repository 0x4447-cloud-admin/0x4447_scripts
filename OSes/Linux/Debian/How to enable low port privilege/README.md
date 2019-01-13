Low Port Nr Privilege

This command will give access to low privilege ports.

Install setcap
sudo apt-get install libcap2-bin

sudo setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/nodejs


