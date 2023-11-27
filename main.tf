terraform {
  required_version = ">= 1.2.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
  backend "s3" {
    bucket = "atfc-bucket"
    key = "dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    dynamodb_table = "atfc-state-lock-table"
  }
}

provider "aws" {
    region = "us-east-1"
    shared_credentials_files = ["~/.aws/credentials"]
    profile = "default"
}

module "vpc" {
  source = "./vpc"
}

module "ec2" {
  source = "./ec2"
  app_security_group = [module.vpc.app_security_group]
  lb_security_group = [module.vpc.lb_security_group]
  rds_endpoint = module.rds.rds_endpoint
  vpc_id = module.vpc.vpc_id
  subnet_lb_ids = module.vpc.sub_public  
}

module "rds" {
  source = "./rds"
  vpc_security_group_ids_var = [module.vpc.db_security_group]
  subnet_ids_var = module.vpc.sub_private
}