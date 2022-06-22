terraform {
  required_version = ">= 0.14.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.6.0" # v4.4.0 has bucket versioning issues
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "aws-s3-mtaquia-backend-ch01"
    key            = "modules/terraform.tfstate" # or "ecs-platform"
    region         = "us-east-1"
    dynamodb_table = "mtaquia-backend-ch01" # for locking
    encrypt        = true
    kms_key_id     = "a5805a87-d915-45b6-b43f-a1a3104ae053" # or "alias/terraform-bucket-key"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "s3-module-ch01" {
  source                      = "./modules/s3"
  s3-bucket-name              = "aws-s3-mtaquia-module-ch01"
  s3-region                   = "us-west-2"
  s3-bucket-acl               = "public-read"
  s3-bucket-allow_access_list = ["arn:aws:iam::719798204634:user/michael.taquia"]
  s3-bucket-versioning        = "Disabled"
  s3-bucket-encrypt           = false
}

module "s3-module2-ch01" {
  source               = "./modules/s3"
  s3-bucket-name       = "aws-s3-mtaquia-module2-ch01"
  s3-region            = "ca-central-1"
  s3-bucket-acl        = "private"
  s3-bucket-versioning = "Enabled"
  s3-bucket-encrypt    = true
  s3-bucket-keyid      = "a5805a87-d915-45b6-b43f-a1a3104ae053"
}

#acl: Valid values are private, public-read, public-read-write, 
#aws-exec-read, authenticated-read, and log-delivery-write. Defaults to private
