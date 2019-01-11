#!/usr/bin/env bash

set -x
export WORKSPACE=$(pwd)
devHostIP=$(docker inspect dev-net | egrep -o '\"Gateway\":.\"([0-9]{1,3}\.){3}[0-9]{1,3}' | egrep -o '([0-9]{1,3}\.){3}[0-9]{1,3}')
export DEV_HOST_IP="$devHostIP"
export MONGO_HOST="$devHostIP"
export FRONT_HOST="$devHostIP"
export FRONT_PORT=4201
export BACK_HOST="$devHostIP"
export SELENIUM_HOST="$devHostIP"

docker network create dev-net || true
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
docker volume rm $(docker volume ls -qf dangling=true)
docker-compose -f docker/docker-compose.yml up -d --force-recreate --build
mongorestore --host $MONGO_HOST --gzip --drop --nsInclude barnacle.* --archive=$WORKSPACE/db/barnacle.test.gz

npm install
npm run test:e2e:remote
