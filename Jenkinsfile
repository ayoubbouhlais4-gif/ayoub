pipeline {
    agent any

    environment {
        IMAGE_NAME     = 'my-node-app'
        IMAGE_TAG      = "${BUILD_NUMBER}"
        CONTAINER_NAME = "test-container-${BUILD_NUMBER}"
        PORT           = '3000'
    }

    stages {
        stage('1. Checkout Code') {
            steps {
                echo '=== Pulling code from GitHub ==='
                checkout scm
            }
        }

        stage('2. Generate Dockerfile with Node 14 Alpine') {
            steps {
                echo '=== Generating Dockerfile dynamically ==='
                sh '''
                cat <<EOF > Dockerfile
FROM node:14-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install || true
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
EOF
                '''
            }
        }

        stage('3. Build Docker Image') {
            steps {
                echo "=== Building Image using node:14-alpine ==="
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('4. Run Container & Test Response') {
            steps {
                echo '=== Starting Container and Running Health Test ==='
                script {
                    sh "docker run -d --name ${CONTAINER_NAME} -p ${PORT}:3000 ${IMAGE_NAME}:${IMAGE_TAG}"
                    
                    sleep 5

                    sh """
                        STATUS=\$(curl -s -o /dev/null -w "%{http_code}" http://localhost:${PORT} || true)
                        echo "Application HTTP Response Code: \$STATUS"
                        
                        if [ "\$STATUS" -eq 200 ]; then
                            echo "Test Passed!"
                        else
                            echo "Test Failed!"
                            exit 1
                        fi
                    """
                }
            }
        }
    }

    post {
        always {
            echo '=== Cleaning up container ==='
            sh """
                docker stop ${CONTAINER_NAME} || true
                docker rm -f ${CONTAINER_NAME} || true
            """
        }
        success {
            echo '========================================='
            echo '  BUILD STATUS: SUCCESS 🎉'
            echo '  App built with node:14-alpine successfully!'
            echo '========================================='
        }
        failure {
            echo '========================================='
            echo '  BUILD STATUS: FAILURE ❌'
            echo '  Pipeline failed during build or test.'
            echo '========================================='
        }
    }
}