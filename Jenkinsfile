pipeline {
    agent any

    stages {
        stage('1. Print Hello') {
            steps {
                echo '=== Hello Ayoub! The pipeline is working! ==='
            }
        }
        stage('2. Test Docker Version') {
            steps {
                sh 'docker --version'
            }
        }
    }
}
