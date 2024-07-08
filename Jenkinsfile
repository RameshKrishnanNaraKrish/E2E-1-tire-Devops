def registry  ='https://ramesh2496devops.jfrog.io/'
pipeline {
    tools {
        maven "maven3"
    }
    agent any
    environment {
        SCANNER_HOME= tool 'sonar-scanner'
    }
    stages {
        stage('Checkout From Git') {
            steps {
                git branch: 'main', url: 'https://github.com/RameshKrishnanNaraKrish/E2E-1-tire-Devops'
            }
        }
        stage('Maven Build') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('Unit Test') {
            steps {
                echo '<----------------------Unit Test Under Progess-------------------->'
                sh 'mvn surefire-report:report'
                echo '<----------------------Unit Test Finished------------------------->'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                script {
                withSonarQubeEnv('sonar-server') {
                sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=E2E-1-tire-Devops -Dsonar.projectKey=RameshKrishnanNaraKrish_E2E-1-tire-Devops '''
                    }
                }
            }
        }
        stage ('Quality Gate'){
        steps {
            script {
                waitForQualityGate abortPipeline: false, credentialsId: 'sonar'
                }
            }
        }
        stage("Jar Publish") {
            steps {
                script {
                        echo '<--------------- Jar Publish Started --------------->'
                            def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"jfrogaccess"
                            def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                            def uploadSpec = """{
                                "files": [
                                    {
                                    "pattern": "target/springbootApp.jar",
                                    "target": "devops-project1-libs-release",
                                    "flat": "false",
                                    "props" : "${properties}"
                                    }
                                ]
                            }"""
                            def buildInfo = server.upload(uploadSpec)
                            buildInfo.env.collect()
                            server.publishBuildInfo(buildInfo)
                            echo '<--------------- Jar Publish Ended --------------->'  
                
                }
            }   
        }
    }
}