pipeline {
  agent any
  tools {
     maven 'maven'
   }
  stages {
    stage('Cloning Git') {
        steps {
          script {
                    properties([pipelineTriggers([pollSCM('H/5 * * * *')])])
                }
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
