pipeline{
    agent any
     environment{
        registry = "261700591476.dkr.ecr.us-east-1.amazonaws.com/omito"
    }
    stages{
     stage('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/dinu2907/OmitoV2.git']]])     
            }
   }
   
    stage('Building image') {
      steps{
        script {
         docker.build registry 
        }
      }
    }
     stage('Push into ECR'){
        steps{
            sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 261700591476.dkr.ecr.us-east-1.amazonaws.com'
            sh 'docker push 261700591476.dkr.ecr.us-east-1.amazonaws.com/omito:latest'
        }
    }
   
    stage('K8S Deployment'){
        steps{
   withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'K8S', namespace: '', serverUrl: '') {
    // some block
    sh "kubectl delete all --all"
    sh "kubectl apply -f eks-deploy-k8s.yaml"
    }
 }
 
  }

    }
  
}
