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