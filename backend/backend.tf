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

module "s3-backend" {
  source                      = "../modules/s3"
  s3-bucket-name              = "aws-s3-mtaquia-backend-ch01"
  s3-region                   = "us-east-1"
  s3-bucket-acl               = "private"
  s3-bucket-versioning        = "Enabled"
  # s3-bucket-allow_access_list = ["arn:aws:iam::719798204634:user/michael.taquia"]
  s3-bucket-encrypt           = true
  s3-bucket-keyid             = aws_kms_key.mykmskey.id
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "mtaquia-backend-ch01"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_kms_key" "mykmskey" {
  description = "This key is used to encrypt bucket objects"
  #deletion_window_in_days = 10
}

resource "aws_kms_alias" "mykmskeyalias" {
  name          = "alias/my-s3key"
  target_key_id = aws_kms_key.mykmskey.key_id
}

output "mykmskey_id" {
  value = aws_kms_key.mykmskey.id
}
