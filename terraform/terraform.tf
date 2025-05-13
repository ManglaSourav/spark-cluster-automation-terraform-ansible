# Specify the required provider for AWS and its version
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

#provider "aws" {
#  region = var.aws_region
#}
