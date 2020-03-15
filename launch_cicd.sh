# Create a bridge network in Docker
sudo docker network create jenkins

# Create volume to share the Docker client TLS certificates needed to connect to the Docker daemon
sudo docker volume create jenkins-docker-certs

# Create volume to persist the Jenkins data 
sudo docker volume create jenkins-data

# To execute Docker commands inside Jenkins nodes (no --rm so you after stopping container it does not get removed)
sudo docker container run --name jenkins-docker --detach \
  --privileged --network jenkins --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --volume "$HOME":/home docker:dind

# Run Jenkins Blue Ocean as container (no --rm so you after stopping container it does not get removed)
sudo docker container run --name jenkins-tutorial --detach \
  --network jenkins --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  --volume "$HOME":/home --publish 8080:8080 jenkinsci/blueocean