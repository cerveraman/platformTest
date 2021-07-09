terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"

    }
  }
}

#Configure the local AWS Provider
provider "aws" {
  access_key                  = var.aws_access_key
  secret_key                  = var.aws_secret_key
  region                      = var.aws_region
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  endpoints {
    ec2      = "http://localhost:4566"
    dynamodb = "http://localhost:4566"
  }
}