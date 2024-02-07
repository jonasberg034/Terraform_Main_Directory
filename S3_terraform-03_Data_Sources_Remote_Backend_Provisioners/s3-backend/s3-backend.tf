terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.35.0"
    }
  }
  backend "s3" {
    bucket = "tf-remote-s3-bucket-clarusways-jonas"
    key = "env/dev/tf-remote-backend.tfstate"         # Bucket icersinde env/dev dizini olusacak ve dosyalar o isimle kaydedilecek.
    region = "us-east-1"
    dynamodb_table = "tf-s3-app-lock"
    encrypt = true
  }
}

# resource "aws_s3_bucket" "tf-test-1" {            # Bunlari birer birer sonradan ekle
#   bucket = "clarusway-test-1-versioning"
# }

# resource "aws_s3_bucket" "tf-test-2" {
#   bucket = "clarusway-test-2-locking-2"
# }


