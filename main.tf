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