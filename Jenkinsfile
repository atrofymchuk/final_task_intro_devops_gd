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
     stage('Read Pom Version') {
       steps {
         script {
            pom = readMavenPom file: 'pom.xml'
            env.POM_VERSION = pom.version
           
         }

           sh '''#!/bin/bash -xe
           echo $POM_VERSION
           '''.stripIndent()
       }
    }
  }
  
}
