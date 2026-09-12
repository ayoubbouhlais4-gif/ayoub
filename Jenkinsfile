// ============================================================
// Jenkins Pipeline: Checkout main -> CI Test -> Docker Build -> Run
// Repository: https://github.com/ayoubbouhlais4-gif/ayoub.git
// Branch: main
// ============================================================

pipeline {
    agent any

    options {
        timestamps()
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '15'))
    }

    environment {
        REPO_URL = 'https://github.com/ayoubbouhlais4-gif/ayoub.git'
        CRED_ID  = 'github-credentials' // هذا هو الاسم المُعرف للـ Token داخل Jenkins
    }

    stages {

        stage('1. Checkout Main Branch') {
            steps {
                echo "Pulling main branch from GitHub..."
                git branch: 'main',
                    url: "${REPO_URL}",
                    credentialsId: "${CRED_ID}"
            }
        }

        stage('2. Install & Run Tests') {
            steps {
                echo "Installing dependencies and testing main code..."
                sh 'npm ci || npm install'
                sh 'npm test'
                sh 'node --check server.js'
            }
        }

        stage('3. Build Docker Image') {
            steps {
                echo "Building Docker image my-node-app:${BUILD_NUMBER}..."
                sh "docker build -t my-node-app:${BUILD_NUMBER} ."
            }
        }

        stage('4. Run Container & Check Health') {
            steps {
                echo "Running container and checking health..."
                sh """
                    docker rm -f my-node-app-test-${BUILD_NUMBER} || true
                    docker run -d --name my-node-app-test-${BUILD_NUMBER} -p 3000:3000 my-node-app:${BUILD_NUMBER}
                """
                script {
                    retry(5) {
                        sleep(time: 3, unit: 'SECONDS')
                        sh 'curl -f http://localhost:3000/health'
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up test container...'
            sh "docker rm -f my-node-app-test-${BUILD_NUMBER} || true"
        }
        success {
            echo "SUCCESS: Build #${BUILD_NUMBER} passed tests and running successfully."
        }
        failure {
            echo "FAILURE: Build #${BUILD_NUMBER} failed."
        }
    }
}