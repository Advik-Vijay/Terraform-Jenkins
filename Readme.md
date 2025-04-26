Terraform-jenkins Project

In this project we have creating the infrasture using terrafom scripts through jenkins pipeline.

Step 1 - Push your terraform codes to the github repository.
Step 2 - Create a ec2 instance, install java and jenkins, install terraform.
Step 3 - After installed jenkins, install the suggested plugins and login as a admin user.
Step 4 - In this project we are creating the insfrastructure in aws cloud, so we need to give our credentials in jenkins.
Step 5 - To give our credentials we need install the "aws steps" plugin.
Step 6 - After that create a job with pipeline and give the below jenkins scripts to create a infrastructure.

**Terraform Infra Automation with Jenkins**
pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                // Clean workspace before cloning (optional)
                deleteDir()

                // Clone the Git repository
                git branch: 'master',
                    url: 'https://github.com/Advik-Vijay/Terraform-Jenkins.git'

                sh "ls -lart"
            }
        }

        stage('Terraform Init') {
                    steps {
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-vijay']]){
                            
                            sh 'echo "=================Terraform Init=================="'
                            sh 'terraform init'
                        
                    }
                }
        }
        stage('Terraform Validate') {
    steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-vijay']]) {
            
                sh 'echo "=================Terraform Validate=================="'
                sh 'terraform validate'
            
        }
    }
}
        stage('Terraform Plan') {
            steps {                           
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-vijay']]){
                            
                                sh 'echo "=================Terraform Plan=================="'
                                sh 'terraform plan'
                            
                        }
                    }
                }        
        stage('Terraform Apply') {
            steps {               
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-vijay']]){
                            
                                sh 'echo "=================Terraform Apply=================="'
                                sh 'terraform apply -auto-approve'
                               
                        }
                    }
                }
        stage('Terraform Destroy') {
            steps {               
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-vijay']]){
                            
                                sh 'echo "=================Terraform Apply=================="'
                                sh 'terraform destroy -auto-approve'
                               
                        }
                    }
                }
            }
        }
