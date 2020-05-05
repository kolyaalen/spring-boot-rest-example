pipeline {
    agent any
        stage('Build Docker Image') {
            steps {
                echo "Build Docker Image step"
                script {
                    app = docker.build("kolyaalen/task_maven")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    echo "Push Docker Image step"
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                        echo "${env.BUILD_NUMBER}"
                    }
                }
            }
        }
    }
}
