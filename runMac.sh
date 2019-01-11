#!/usr/bin/env bash
WORKSPACE=$(pwd)
#docker-machine start stage
eval "$(docker-machine env stage)"
docker network create dev-net || true
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
docker volume rm $(docker volume ls -qf dangling=true)
docker-compose -f docker/docker-compose.yml up -d --force-recreate --build
devHostIP=$(env | grep DOCKER_HOST | egrep -o '([0-9]{1,3}\.){3}[0-9]{1,3}')
export DEV_HOST_IP="$devHostIP"
export MONGO_HOST="$devHostIP"
export FRONT_HOST="$devHostIP"
export FRONT_PORT=4201
export BACK_HOST="$devHostIP"
export SELENIUM_HOST="$devHostIP"
mongorestore --host $MONGO_HOST --gzip --archive=$WORKSPACE/db/barnacle.test.gz --db barnacle
npm run test:e2e:remote
