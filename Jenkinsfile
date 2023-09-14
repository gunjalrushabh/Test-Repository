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
                    dockerImage.push()
                }
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                // Deploy to Kubernetes using kubectl
                sh 'kubectl apply -f path/to/kubernetes/deployment.yaml'
            }
        }
    }
}
