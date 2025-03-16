terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.2"
    }
  }
  backend "s3" {
    bucket  = "better-infrastructure-management-with-terraform"
    key     = "refactoring/terraform.tfstate"
    region  = "eu-west-1"
    profile = "academy"
  }
}

provider "aws" {
  region  = "eu-west-1"
  profile = "academy"
  assume_role {
    role_arn = "arn:aws:iam::338791806049:role/exercise_03_role"
  }
}