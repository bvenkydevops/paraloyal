piepline{
  agent any
  stages{
    stage("Code Analysis"){
      steps{
        sh 'sonar-scanner'
       }
    }
    stage("Build & Provision"){
      steps{
         script {
                    sh 'mvn clean install'
                    sh 'ansible-playbook -i inventory.ini deploy.yml'
          } 
       }
    }
    stage("Automated Testing"){
      steps{
         script {
                    sh 'selenium-test.sh'
             }
           }
         }
    stage("Artifact Deployment"){
      steps{
         script {
                    sh 'aws s3 cp target/*.jar s3://your-s3-bucket/'
                }
            }
        }
    stage('EKS Cluster Deployment') {
            steps {
                script {
                    sh 'kubectl apply -f eks-deployment.yaml'
                }
            }
        }

    post {
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed. Check the logs for details.'
        }
    }
}
