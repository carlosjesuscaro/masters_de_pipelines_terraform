terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.6.2"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "eu-west-1"
}
