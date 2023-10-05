pipeline {
    agent any

    stages {
        stage('SCM') {
            steps {
                git branch: 'main', credentialsId: 'github_user_password', url: 'https://github.com/devkishanjoshi/sample-java-app.git'
            }
        }
        
        stage('Maven Build') {
            steps {
                sh "mvn clean package -DskipTests=true"
            }
        }
        
        stage('Build') {
            steps {
                sh "docker build -t devil1211/myappjava:v1 . "
            }
        }
        
        stage('Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                sh "echo Successfully logged in "
                sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                sh "docker push devil1211/myappjava:v1 "
                 }
            }
        }
        
         stage('Deploy') {
            steps {
                sh "docker run -dit -p 85:8080 devil1211/myappjava:v1"
            }
        }
        
    }
}
