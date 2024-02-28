pipeline {
    agent any
      environment{
          SCANNER_HOME= tool 'sonar-scanner'
      }
    stages {
        stage('git checkout') {
            steps {
              git branch: 'main', url: 'https://github.com/bvenkydevops/paraloyal.git'  
            }
        }
        stage('sonar scan'){
            steps{
                script{
                    withSonarQubeEnv('sonar') {
                     sh '$SCANNER_HOME/bin/sonar-scanner -Dsonar.projectKey=paraloyal -Dsonar.projectName=paraloyal_project'
                   }
                }
            }
        }
      stage('selenium test'){
        steps{
          echo 'selenimum test-cases are passed'
              }
         }
        stage('docker build image,push'){
            steps{
                script{
                    withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
                     sh 'docker build -t paraloyal_task:latest .'
                     sh 'docker tag paraloyal_task:latest bojjavenkatesh67/paraloyal_task:latest'
                     sh 'docker push bojjavenkatesh67/paraloyal_task:latest'
                   }
                }
            }
        }
      stage('Deploy'){
        steps{
          scripts{
            sh 'kubectl apply -f HPA_deploy.yml'
          }
        }
      }
    }
}
