pipeline {
    agent any

    environment {
        KUBECONFIG_CREDENTIALS = credentials('kubeconfig')
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials') // Optional, only if you need to push to a registry
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Check out the code from Git
                git 'https://github.com/gunjalrushabh/Test-Repository.git'

                sh 'chmod +x gradlew'
            }
        }
        
        stage('Build') {
            steps {
                // Build the Gradle project
                sh './gradlew build'
            }
        }
        
        stage('Docker Build') {
            steps {
                // Build Docker image
                script {
                    def dockerImage = docker.build("test-image:${BUILD_NUMBER}")

                    // Authenticate with Docker Hub using the credentials
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                    }
                    // Tag the Docker image with your Docker Hub username and repository
                        sh "docker tag test-image:${BUILD_NUMBER} $DOCKER_USERNAME/test-image:${BUILD_NUMBER}"

                        // Push the Docker image to Docker Hub
                        sh "docker push $DOCKER_USERNAME/test-image:${BUILD_NUMBER}"
                    //dockerImage.push()
                }
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                // Deploy to Kubernetes using kubectl
                sh 'kubectl apply -f /home/ubuntu/deployment.yaml'
            }
        }
    }
}
