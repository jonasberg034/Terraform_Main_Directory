terraform {                  # Bu blok olmadan da bu dosya calisirdi. 
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.35.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

resource "aws_instance" "tf-ec2" {
  ami           = "ami-0277155c3f0ab2930"
  instance_type = "t2.micro"
  tags = {
    "Name" = "created-by-tf"
  }
}

