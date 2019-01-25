#### SSH Keys creation
```
$ docker exec -it <CONTAINER_ID> /bin/bash

$ sudo su jenkins
$ whoami 
> jenkins

$ ssh-keygen
ssh-keygen -t rsa -b 4096 -C "<E-MAIL>"
(Leave file name empty)
(Leave password empty)

$ ctrl + D
$ whoami 
> root

$ cd /var/jenkins_home/.ssh

# Use the content for git account key settings
$ cat id_rsa.pub

# Use the content fot jenkins credential settings
$ cat id_rsa

```

#### Using credentials via env variables
```
withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
    sh 'docker push dkanunik/barnacle-back:latest'
}
```
