# Docker Cheat Sheet

Mount a local dir and login to the docker

docker run -it -v /tmp:/tmp IMAGE ID /bin/bash

1. `docker pa -a`

  List all the containers that you have in yu system, including thoes that are stoped.

1. `docker images`

  List all the images on your system

1. `docker rm CONTAINER ID`

  Deletes the cointainer from the system

1. `docker rmi IMAGE ID`

  Delets a selected image from you system

1. `docker run -p 3000:5000 -d --name CONTAINER_NAME IMAGE_ID`

  Run an image and map the port 3000 for example from the hosted system to the 5000 port that you app is running on for example

1. `docker logs CONTAINER ID`

  Show the logs of your running app

1. `docker run -it IMAGE ID /bin/bash`

  Log in to the container with bash and interact with the system as a nomral one

1.  `docker build -t debina/nodejs:6.9.4 DIR OF THE PROJECT`

  Build an image from a docker file

1. `docker exec -it CONTAINER ID /bin/bash`

  Log in in to a container

1. `docker run -v /host/absolute/path/:/container/path -p 3000:5000 -d IMAGE ID`

  Mount a folder from the host system to the container

1. `docker run -e Key=Value -p 3001:5000 -d IMAGE_ID`

  Pass [env](https://docs.docker.com/engine/reference/commandline/run/#/set-environment-variables--e---env---env-file) variables to the container

1. `docker images -q --filter "dangling=true" | xargs docker rmi`

  Remove all untaged images

1. `docker rm "docker ps --no-trunc -aq"`

  Remove all stoped containers

1. `docker run -ti --name $(basename $(pwd)) --rm -p 3000:3000 -v $(pwd):/app -w /app node:slim sh -c 'npm start'`

  Mount the workign dirrectory inside the container, set the right workign dirrectory, and run a command from that dirrectory. Know also as developer mode, so as developer you can work.

1. `sudo docker run -d --name CONTAINER_NAME --restart unless-stopped IMAGE_ID`

  Make sure the cointanier will keep on working and restart iteselfe unelss we say so. Other options: `no`, `on-failure`, `unless-stopped`

1. `docker run -ti --rm -v $(pwd):/app -w /app node:slim sh -c 'apt-get update && apt-get install -y build-essential && apt-get install -y python && npm install'`

  Install esentials for C compilation, and Python before makieng npm install so we can compile bcrypt

1. `--link redis`

  Will add in the `/etc/hosts` file the right entry to poitn to the container with Redis in this case

1. `docker run -it --rm -v $(pwd):/app -w /app node:slim sh -c 'npm install'`

  Run a command insdie docker