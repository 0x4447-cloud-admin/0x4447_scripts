# How to Generate a RSA Private Key

This will make a private and public key

`ssh-keygen -t rsa -b 4096 -f file.pem`

This will generate the public key from the private one

`ssh-keygen -y`