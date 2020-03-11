pipeline {
    agent {
        docker {
            image 'node:12-alpine'
            args '-p 3000:3000 -p 5000:5000'
        }
    }
    environment {
        CI = 'true'
    }
    stages {
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
        stage('Test') {
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

        stage('Package Docker and deploy in remote server') {
            when {
                branch 'production'
            }
            steps {
                sh './jenkins/scripts/kill.sh'
                sh 'export DOCKERID=hwlee96'
                sh 'docker image build --tag $DOCKERID/my-website:1.0 .'
                sh 'docker run -p 49160:5000 -d --name my_website $DOCKERID/my-website:1.0'
                sh 'curl -i localhost:49160'
                input message: 'Finished using the web site before removing docker build? (Click "Proceed" to continue)'
                sh 'docker container stop my_website'
                sh 'docker image rm $DOCKERID/my-website:1.0'

            }
        }
    }
}
