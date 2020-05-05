pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Running build'
                sh 'mvn clean package'
                archiveArtifacts artifacts: 'target/spring-boot-rest-example-0.5.0.war'
            }
        }
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
        stage('DeployToProduction') {
            steps {
                input 'Deploy to Production?'
                milestone(1)
                withCredentials([usernamePassword(credentialsId: 'webserver', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]) {
                    script {
                        sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod \"docker pull kolyaalen/task:${env.BUILD_NUMBER}\""
                        try {
                            sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod \"docker stop kolyaalen_task\""
                            sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod \"docker rm kolyaalen_task\""
                        } catch (err) {
                            echo: 'caught error: $err'
                        }
                        sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod \"docker run --restart always --name kolyaalen_task -p 8080:8080 -d kolyaalen/task:${env.BUILD_NUMBER}\""
                    }
                }
            }
        }
    }
}
