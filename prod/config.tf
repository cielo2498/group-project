provider "aws" {
region = "us-east-1"
}


terraform {
  backend "s3" {
    bucket = "prjs3-1"            // Bucket from where to GET Terraform State
    key    = "terraform.tfstate1" // Object name in the bucket to GET Terraform State
  #  key    = "dev/network/terraform.tfstate" // Object name in the bucket to GET Terraform State
    region = "us-east-1"                       // Region where bucket created
  }
}
