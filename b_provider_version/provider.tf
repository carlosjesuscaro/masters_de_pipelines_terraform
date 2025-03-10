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
  region  = "eu-west-1"
  profile = "default_profile"
  assume_role {
    role_arn = "arn:aws:iam::164686679788:role/service-role/s3_trail_to_cloudwatch"
  }
}

