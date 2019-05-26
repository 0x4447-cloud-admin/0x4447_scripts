# How to use SSH to tunnel connection between machines

# SSH local port forwarding

This options allows you to tell the local computer that you want all traffic from a selected local port to be routed to the remote machine that you connected to via SSH.

`ssh -L 8181:10.0.1.89:5432 user@remote_server`

Leggend:

- ssh: the app to run
- -L: local port forwarding
- 8181: is the local port that you want to use
- IP: can be localhost if the server you want to connect is running on the same server you are connecting to. Or, you can specify another server within the LAN of the server you concede to.
- 5432: remote port where you want your data to be sent to.
- user@remote_server: the remote server details, you can also use a .ssh/config file.

This option is also ideal when working with AWS, and you put for example a database in a VPC network not accessible from the outside world. If you start an EC2 instance in the public subnet, and ssh -L to it, you can route the traffic to the local database, thus allowing you to use a GUI application to manage your database otherwise unavailable on the internet.

# SSH dynamic forwarding

With dynamic port forwarding you can send all the traffic to the selected port, essentially setting up a Proxy server but without the cashing.

`ssh -D 8181 mc_default`

This solution is application specific, meaning the application that you want to use needs to have a Proxy setting, with the option to Socks Proxy. If you put the credentials `localhost:8181`, then the browser will send all the traffic to that port.

# SSH in to port forwarding

To do the revers, meaning have someone connect to the local machine that you in. You can use the Reverse setting:

`ssh -R 8181:localhost:5432 user@remote_server`

On the computer that you want others to connect to, you type the the command above.

Leggend:

- ssh: the app to run
- -R: Revers forwarding
- 8181: is the local port that you want to use
- IP: can be localhost for the computer that you are typing this in. Or another IP within the local network of the computer that you are typing this in.
- 5432: the port where you want your data to be sent to.
- user@remote_server: the remote server details, you can also use a .ssh/config file.

For this to work, you need to set `GatewayPorts yes` in your SSH server configuration.

You can also use a service like http://serveo.net/ to expose a server to the public that you are running.