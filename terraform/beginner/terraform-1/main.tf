provider "aws" {
    region = "us-east-1"
}

resource "aws_s3_bucket" "DemoTerraformBucket" {
    bucket = "super-unique-name-0723"
  
}