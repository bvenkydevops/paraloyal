pipeline{
  agent any
      environment{
        SCANNER_HOME= tool 'sonar-scanner'
      }
    stages {
        stage('git checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/bvenkydevops/paraloyal.git']])
            }
        }
        stage('sonarQube Scan'){
            steps{
                 withSonarQubeEnv('sonar-scanner') {
                  sh '$SCANNER_HOME/bin/sonar-scanner -Dsonar.projectKey=paraloyal -Dsonar.projectName=paraloyal_project' 
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
    }
}
