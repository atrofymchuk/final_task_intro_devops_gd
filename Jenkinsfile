pipeline {
  agent any
  tools {
     maven 'maven'
   }
  stages {
    stage('Cloning Git') {
        steps {
          git branch: 'main',
                url: 'https://github.com/atrofymchuk/spring-petclinic.git'
        }
      }
    stage("Pre-build") {
              steps {
                      withMaven(maven: 'maven', mavenSettingsConfig: 'mvn-setting-xml') {
                      sh "mvn clean package"
                      }
               }
     }
  
  }
  
}
