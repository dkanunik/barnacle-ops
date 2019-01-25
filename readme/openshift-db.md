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