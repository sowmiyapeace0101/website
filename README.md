# Personal DevOps Project

* Description: To apply DevOps knowledge self-learnt by building a pipeline from development to production/deployment.
* DevOps stack used:
  * Terraform (Provisioning/Configuration)
  * Git (Version Control)
  * Continuous Integration/Deployment 
* Consists of 2 systems: 1. Development & 2. Production 
* DevOps stack: Git(Version Control), Docker (Containerization), Jenkins (CI/CD), 

## Production
(Instructions to pull from private registry in Docker)

## Development
* Dev Stack: React (frontend), NodeJS (backend, server-side)

### CI/CD (Multibranch) Pipeline Instructions

Pre-requisites: [Docker(Ubuntu)](https://docs.docker.com/install/linux/docker-ce/ubuntu/) and [Docker Compose](https://docs.docker.com/compose/install/)

1. For first time running Jenkins CI/CD pipeline, 

* Run ```launch_cicd.sh``` to create bridge network, volumes to share the Docker client TLS certificates needed to connect to the Docker daemon and persist the Jenkins data  and run Docker(-in-Docker) and Jenkins containers.

```chmod +x launch_cicd.sh```

```./launch_cicd.sh```

* Follow instructions for [Setup Wizard](https://jenkins.io/doc/tutorials/build-a-multibranch-pipeline-project/#setup-wizard) section if accessing a new Jenkins instance. 

2. If you already have the Jenkins instance launched, to start and stop the containers, run: 

```sudo docker container start jenkins-tutorial jenkins-docker```

```sudo docker container stop jenkins-tutorial jenkins-docker```
