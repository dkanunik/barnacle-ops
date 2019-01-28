#### Build images

Dockerfile:
```
FROM node:8
WORKDIR /barnacle
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
EXPOSE 4201
CMD [ "npm", "run", "front:start" ]
```

Building:
```
$ docker build -t dkanunik/barnacle-front:latest .
```

#### Image tags
To mark the image with a tag:
```
$ docker tag <IMAGE_ID> <PROJECT_NAME>/<IMAGE_NAME>:<TAG>
```
Example:
```
$ docker tag 062702776e92  dkanunik/barnacle-front:latest
```
To remove a tag from an image:
```
$ docker rmi <IMAGE>:<VERSION>
```

#### Remove image
```
$ docker rmi <IMAGE_ID>
```

#### Push image:
```
$ docker push dkanunik/barnacle-front:latest
```

#### Run containers via docker-compose.yml

YML-file:
```
back:
  container_name: back
  image: dkanunik/barnacle-front:last
  ports:
    - "3000:3000"
  environment:
    - MONGO_HOST=$MONGO_HOST
  networks:
    - dev-net
  depends_on:
    - mongo

front:
  container_name: front
  dkanunik/barnacle-front:last
  ports:
    - "4201:4201"
  networks:
    - dev-net
  depends_on:
    - back
```
To start build and start containers:
```
docker-compose -f docker/docker-compose.yml up -d
```

#### Save image
```
$ docker build -t dkanunik/barnacle-front:latest .
$ docker save dkanunik/barnacle-front:latest > barnacle-front.tar
$ zip barnacle-front.tar barnacle-front.zip
```

#### Load image
```
$ unzip barnacle-front.zip
$ docker load --input barnacle-front.tar
$ docker images

REPOSITORY                                 TAG                 IMAGE ID          
dkanunik/barnacle-front                 latest              80cb2045f41b         
```

#### Container IP getting
```
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <id>
```

#### Resource cleaning (CLI)
Stop containers:
```
docker stop $(docker ps -a -q)
```
Remove containers:
```
docker rm $(docker ps -a -q)
```
Remove images:
```
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
```
Remove volumes:
```
docker volume rm $(docker volume ls -qf dangling=true)
```

#### Resource cleaning (Shell)
```
#!/bin/bash

# Stop all containers
containers=`docker ps -a -q`
if [ -n "$containers" ] ; then
        docker stop $containers
fi

# Delete all containers
containers=`docker ps -a -q`
if [ -n "$containers" ]; then
        docker rm -f -v $containers
fi

# Delete all images
images=`docker images --filter "dangling=true" -q --no-trunc`
if [ -n "$images" ]; then
        docker rmi -f $images
fi
```