#Terraform Block
terraform {
  required_providers {
    source = "hashicorp/aws"
    version = "4.23.0"
  }
    backend "s3" {
    bucket = "greens-workshop-april19"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }  
}

#Provider Block
provider "aws" {
  region = "us-east-1"
  profile = "default"
}