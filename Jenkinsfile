def TAG_SELECTOR = "UNINTIALIZED"
pipeline {
  agent any
  tools {
     maven 'maven'
   }
  stages {
    stage('Cloning Git') {
        steps {
          script {
                    properties([pipelineTriggers([pollSCM('H/15 * * * *')])])
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
                      script {
                      TAG_SELECTOR = readMavenPom().getVersion()
                      }
                      echo("TAG_SELECTOR=${TAG_SELECTOR}")
               }
     }
  
  }
  
}
