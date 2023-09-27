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
                    def dockerImage = docker.build("vikasc325/test-image:${BUILD_NUMBER}")

                    // Authenticate with Docker Hub using the credentials
                   withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
    }
                    // Tag the Docker image with your Docker Hub username and repository
                        //sh "docker tag test-image:${BUILD_NUMBER} $DOCKER_USERNAME/test-image:${BUILD_NUMBER}"

                        // Push the Docker image to Docker Hub
                        //sh "docker push $DOCKER_USERNAME/test-image:${BUILD_NUMBER}"
                    dockerImage.push()
                }
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                script {
            // Define your SSH credentials ID
            def sshCredentialsId = 'jenkins-ssh-key'
        // Deploy to Kubernetes on a remote server using SSH
         // Use the sshagent step to run commands inside an SSH agent
            sshagent(credentials: [sshUserPrivateKey(credentialsId: sshCredentialsId, keyFileVariable: 'SSH_KEY')]) {
                // You can now run SSH commands securely using the SSH_KEY variable
                sh 'ssh -i $SSH_KEY user@remote-server "kubectl apply -f /home/ubuntu/deployment.yaml"'
            }
                }
        }
    }
}
}
