node{
   stage('SCM Checkout'){
      git credentialsId: 'git-creds', url: 'https://github.com/guipal/apiSampleJava'
   }
   stage('Mvn Package'){
     def mvnHome = tool name: 'maven-3', type: 'maven'
     def mvnCMD = "${mvnHome}/bin/mvn"
     sh "${mvnCMD} clean package"
   }
   stage('Build Docker Image'){
     sh 'docker build -t SampleJavaApp:0.0.1 .'
   }
   #push DockerImage to DockerHub
   stage('Push Docker Image'){
     withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerHubPwd')]) {
        sh "docker login -u {dockerHub-username} -p ${dockerHubPwd}"
     }
      sh 'docker push {dockerHub-Repo_URL}''. # we can add commit ID as well to identy the image name easily.
   }
   #Running Docker Image as a Container in TestEnviornment.
   stage('Run Container on Test Enviornment'){
     def dockerRun = 'docker run -p 8080:8080 -d --name SampleJavaApp '
     }
   # Testing the container, wheather app is running or not.
     stage ("Verify Service Up or Not"){
     sh "scripts/verify_app.sh http://{testserverip}:8080" | grep 'Hello World'
  }
  env.BUILD_STATUS="Successful"
  stage ("Trigger remote tests (PlaceHolder, Need to give correct test)"){
  // sh "curl --data 'TestName=testName' http://:8080/job/QA%20RESEARCH%20AND%20DEVELOPMENT/job/Testing%20Runs/   buildWithParameters"
  echo "Need to replace with correct tests!"
}

  stage ("Pulling docker image in production-envionment and deploying")
     sh 'scripts/prod-deploy.sh'
   }
  stage("verify service is up.")
  sh "scripts/verify_app.sh http://{serverip}:8080" | grep 'Hello World'
}
catch (err) {
    echo "Failed: ${err}"
    env.BUILD_STATUS="Failed"
    currentBuild.result="Failed"
}
finally {
stage("Send Email Notification"){
emailext attachLog: true, body: "${env.JOB_BASE_NAME} - Deploy App # ${DEPLOY_VERSION} -${env.BUILD_STATUS}!:-Check console output at ${env.BUILD_URL} to view the results.", replyTo: '$DEFAULT_REPLYTO', subject: "${env.JOB_BASE_NAME} - Deploy # ${DEPLOY_VERSION} - ${env.BUILD_STATUS}! ", to: '$DEFAULT_RECIPIENTS'
  }
}
}
