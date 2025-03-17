terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.22.0"
    }
  }
}

# Setting up the provider through a module
module "provider" {
  source = "./modules"
  aws_region = "us-east-2"
}
