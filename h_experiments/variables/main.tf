terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.22.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  # region  = "us-east-2"
  region = var.aws_region
  profile = "default_profile"
}


