terraform {
  backend "s3" {
    bucket         = "aws-s3-mtaquia-backend-ch01"
    key            = "modules/terraform.tfstate" # or "ecs-platform"
    region         = "us-east-1"
    dynamodb_table = "mtaquia-backend-ch01" # for locking
    encrypt        = true
    # kms_key_id = "THE_ID_OF_THE_KMS_KEY" 
  }
}

module "s3-backend" {
  source                      = "./modules/s3"
  s3-bucket-name              = "aws-s3-mtaquia-backend-ch01"
  s3-bucket-acl               = "private"
  s3-bucket-versioning        = "Enabled"
  s3-bucket-allow_access_list = ["arn:aws:iam::719798204634:user/michael.taquia"]
  s3-bucket-encrypt           = true

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
