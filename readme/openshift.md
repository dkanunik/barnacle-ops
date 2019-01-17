## Openshift

#### Environment
##### Init:
```
$ minishift start

$ eval $(minishift oc-env)

$ eval $(minishift docker-env)

$ oc login -u system:admin
> 192.168.99.100:8443
> yes

$ docker login -u developer -p $(oc whoami -t) $(minishift openshift registry)

$ docker images
```

#### Images
##### Build image:
```
# format 
$ docker build -t <REGISTGRY_IP>:<PORT>/<REPOSITORY>/<IMAGE>:<VERSION> .

# registry ip getting
$ echo $(minishift openshift registry)
> 172.30.1.1

# example
$ docker build -t 172.30.1.1:5000/barnacle/barnacle-front:latest .
$ docker build -t 172.30.1.1:5000/barnacle/barnacle-back:latest .
```


##### Tag image:
To mark the image with a tag:
```
$ docker tag <IMAGE_ID> $(minishift openshift registry)/<PROJECT_NAME>/<IMAGE_NAME>:<TAG>
```
Example:
```
$ docker tag 062702776e92  $(minishift openshift registry)/barnacle/barnacle-front:latest
```

To remove a tag from an image:
```
$ docker rmi <IMAGE>:<VERSION>
```

##### Push image:
```
$ docker push  $(minishift openshift registry)/barnacle/barnacle-front
```

#### Deployment
##### Creating deployment:
```
# format
$ oc create -f <file_or_dir_path>

# example
$ oc create -f barnacle-ops/k8s/back-deploy.yml
```

##### Getting deployment:
```
oc get deployments
```

##### Deleting deployment:
```
oc delete deployment barnacle-back
```

#### Pod
Get logs:
```
$ oc logs <POD_NAME>
```

#### DB 
##### DB application install
```
$ oc new-app \
 -e MONGODB_USER=barnacle \
 -e MONGODB_PASSWORD=barnacle \
 -e MONGODB_DATABASE=barnacle \
 -e MONGODB_ADMIN_PASSWORD=dbadmin \
 mongodb:2.6
```

##### DB config
Creating a db user:
```
$ oc rsh <MONGO_POD_ID>
$ env | grep MONGO
$ mongo -u admin -p $MONGODB_ADMIN_PASSWORD admin
$ user barnacle
$ db.createUser(
   {
     user: "barnacle",
     pwd: "barnacle",
     roles: [ "readWrite", "dbAdmin" ]
   }
)

$ db.barnacle.insert({"name":"animal"})
$ db.barnacle.find()
```

##### DB access
To connect within a cluster
```
$ mongo --host mongodb://barnacle:barnacle@mongodb.barnacle.svc/barnacle
```

To setup port forwarding between a local machine and the database running on OpenShift:
```
# format
$ oc port-forward <pod-name> <local-port>:<remote:port>

# example
$ oc port-forward mongodb-1-d778w 27017:27017
```

Testing login:
```
$ mongo --host mongodb://barnacle:barnacle@localhost/barnacle
```

#### Trouble shooting
```
$ minishift delete --clear-cache
```