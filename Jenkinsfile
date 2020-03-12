pipeline {
    agent none
    environment {
        CI = 'true'
        registry = "hwlee96/my-website"
        registryCredential = 'docker-hub-credentials'
        dockerImage = ''
    } 
    stages {
        stage('Build') {
            when {
                not {
                    branch 'master'
                }
            }            
            steps {
                sh 'npm install'
            }
        }
        stage('Test') {
            when {
                not {
                    branch 'master'
                }
            } 
            steps {
                sh './jenkins/scripts/test.sh'
            }
        }
        stage('Deliver for development') {
            when {
                branch 'development'
            }
            steps {
                sh './jenkins/scripts/deliver-for-development.sh'
                input message: 'Finished using the web site? (Click "Proceed" to continue)'
                sh './jenkins/scripts/kill.sh'
                sh 'echo $BUILD_NUMBER'
            }
        }
        stage('Deploy for production') {
            when {
                branch 'production'
            }
            steps {
                sh './jenkins/scripts/deploy-for-production.sh'
                input message: 'Finished using the web site? (Click "Proceed" to continue)'
                sh './jenkins/scripts/kill.sh'
            }
        }

        stage('Build image and test (manually)') {
            // build a container based on this Dockerfile and then run the defined steps using that container
            // agent { dockerfile trueage }
            when {
                branch 'master'
            }
            agent {
                label 'master'
            }
            // environment {
            //     jenkinsdockerIP = "${sh(script:'hostname -i', returnStdout: true)}"
            // }
            steps {
                echo "Starting build"
                script {
                    dockerImage = docker.build registry
                    sh 'echo "Ended build"'
                    // For withRun, it automatically stops the container at the end of a block
                    // And unlike inside, shell steps inside the block are not run inside the container
                    // docker.image(registry).withRun('-p 49160:5000') { c ->
                    //     sh "curl -i $jenkinsdockerIP:49160"
                    //     sh 'echo "Container is successful" '
                    // }     
                }
            }
        }

        stage('Push image to dockerhub registry') {
            when {
                branch 'master'
            }
            agent {
                label 'master'
            }
            steps {
                script{
                    docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
                        dockerImage.push("${env.BUILD_NUMBER}")
                        dockerImage.push("latest")
                    }
                }
                sh "docker rmi $registry"
            }
        }
    }
}
