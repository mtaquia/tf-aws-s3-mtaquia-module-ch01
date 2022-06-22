terraform {
  required_version = ">= 0.14.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.6.0" # v4.4.0 has bucket versioning issues
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "s3-module-ch01" {
  source               = "./modules/s3"
  s3-bucket-name       = "aws-s3-mtaquia-module-ch01"
  s3-bucket-acl        = "private"
  s3-bucket-versioning = "Disabled"
  s3-bucket-encrypt    = false
}

#acl: Valid values are private, public-read, public-read-write, 
#aws-exec-read, authenticated-read, and log-delivery-write. Defaults to private