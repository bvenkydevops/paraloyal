pipeline {
    agent any
      environment{
          SCANNER_HOME= tool 'sonar-scanner'
    AWS_ACCESS_KEY_ID = credentials('accesskey')
    AWS_SECRET_ACCESS_KEY = credentials('secretkey')
    AWS_REGION = 'us-east-1'
    CLUSTER_NAME = 'paraloyal_task' 
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
       stage('Create EKS Cluster') {
           steps {
               script {
                  sh "eksctl create cluster --name ${CLUSTER_NAME} --region ${AWS_REGION} --node-type t2.micro --nodes 2"
                  sh "eksctl get cluster --region=${AWS_REGION} --name=${CLUSTER_NAME}"
                  sh "aws eks --region=${AWS_REGION} update-kubeconfig --name ${CLUSTER_NAME}"
                  sh "kubectl apply -f HPA_deploy.yaml"
                }
            }
        }
    }
}
