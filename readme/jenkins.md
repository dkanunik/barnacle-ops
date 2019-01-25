#### Jenkins installation
```
docker run \
  -u root \
  --rm \
  -d \
  -p 8080:8080 \
  -p 50000:50000 \
  -v jenkins-data:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkinsci/blueocean
```
[Manual](https://jenkins.io/doc/book/installing/)

#### Required plugins
* https://plugins.jenkins.io/nodejs
* https://plugins.jenkins.io/docker-plugin