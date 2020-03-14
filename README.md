# Personal DevOps Project

## Introduction

* **Purpose**: To apply DevOps knowledge self-learnt by efficiently automating pipeline from development to deployment of my own personal portfolio website.

* **Summary**: Project focuses on applying DevOps tools for automation of workflow. Current pipeline is: CI/CD pipeline, through Jenkins container integrated with Docker, to pull containers required, run and test web application, build docker images after tests are passed and push to [personal docker hub registry](https://hub.docker.com/repository/docker/hwlee96/my-website).

* **Note**: front-end is not yet established and currently only contains sidebar for profile details as this project focuses on applying and building DevOps principles and pipeline automation. 

* **DevOps stack**:
  - [x] Git (Version Control)
  - [x] Docker (Containerization)
  - [x] Jenkins (CI/CD)
  - [ ] Terraform (Provisioning/Configuration) - To be used
  - [ ] ELK Stack / Nagios (Monitoring) - To be learnt and applied
  - [ ] Kubernetes (Container Orchestration) - To be learnt and applied

* **DevOps stack**:
  - [x] HTML, CSS, React (Static front-end)
  - [x] NodeJS  (Static HTTP server for now)

## CI/CD (Multibranch) Pipeline Details 

### Instructions to start CI/CD multi-branch pipeline
Pre-requisites: [Docker(Ubuntu)](https://docs.docker.com/install/linux/docker-ce/ubuntu/) and [Docker Compose](https://docs.docker.com/compose/install/)

1. For first time running Jenkins CI/CD pipeline, 
    * Run ```launch_cicd.sh``` to create bridge network, volumes to share the Docker client TLS certificates needed to connect to the Docker daemon and persist the Jenkins data  and run Docker(-in-Docker) and Jenkins containers.
    * Run ```chmod +x launch_cicd.sh``` before running ```./launch_cicd.sh```
    * Follow instructions for [Setup Wizard](https://jenkins.io/doc/tutorials/build-a-multibranch-pipeline-project/#setup-wizard) section if accessing a new Jenkins instance. 

2. If you already have the Jenkins instance launched, to start and stop the containers, run: 
    ```sudo docker container start jenkins-blueocean jenkins-docker```
    ```sudo docker container stop jenkins-blueocean jenkins-docker```

### Current workflow for multi-branch CI/CD pipeline
1. CI/CD pipeline currently has 3 branches with different stages:
    * Branch pipeline to run in order: ```development```, ```production```, ```master```
    * ```development``` branch: To run and test development build 
      - [x] ```Build``` stage: Pull, run node container from docker registry and install node modules
      - [x] ```Test``` stage: runs basic tests (for now) in src/App.test.js 
      - [x] ```Deliver for development```: user acceptance test for development build
    * ```production``` branch: To run and test production build with [static server](https://github.com/zeit/serve)
        - [x] ```Build``` stage: Pull, run node container from docker registry and install node modules
      - [x] ```Test``` stage: runs basic tests (for now) in src/App.test.js 
      - [x] ```Deliver for production```: user acceptance test for production build
    * ```master``` branch: To deploy application on remote server
      - [x] ```Build image``` stage: Build docker images from Dockerfile
      - [x] ```Push Image``` stage: Push to personal docker hub registry 
      - [ ] SSH into remote server, pull image and run web app container (not completed yet)
    * Current build can be found in [my docker hub repository](https://hub.docker.com/repository/docker/hwlee96/my-website).

2. After completing ```master``` branch pipeline (with built image pushed to docker hub registry), to run container from image: 
  ```sudo docker run -d --rm -p <port-on-host>:5000 --name <name-of-container> hwlee96/my-website```

3. Access (static) web app at: 
  ```http://localhost:<port-on-host>/```

4. To stop (and remove because of --rm argument), run 
  ```sudo docker container stop <name-of-container>```

5. To remove image, run 
  ```sudo docker rmi hwlee96/my-website:latest```

### Some good security practices
* Store sensitive information (e.g. docker registry password, SSH key) in the credentials settings in Jenkins UI Platform. Reference to respective credentials through ID field.
  * In this project thus far, my credentials for my docker hub registry are referenced through the ```registryCredential``` environment variable set in Jenkinsfile.
