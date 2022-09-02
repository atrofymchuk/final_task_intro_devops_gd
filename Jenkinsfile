pipeline {
  agent any
  tools {
     maven 'maven'
   }
  stages {
    stage("Pre-build") {
              steps {
                      withMaven(maven: 'maven', mavenSettingsConfig: 'mvn-setting-xml') {
                      sh "mvn clean package"
                      }
               }
     }
  
  }
  
}
