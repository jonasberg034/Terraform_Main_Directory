provider "aws" {
  region  = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.58.0"
    }
  }
}

locals {
  mytag = "clarusway-local-name"
}

data "aws_ami" "tf_ami" {
  most_recent      = true   # en son olusan image alacak
  owners           = ["self"]

  filter {
    name = "virtualization-type" # Dokumentasyona bak
    values = ["hvm"]
  }
}

variable "ec2_type" {
  default = "t2.micro"
}

resource "aws_instance" "tf-ec2" {
  ami           = data.aws_ami.tf_ami.id
  instance_type = var.ec2_type
  key_name      = "aduncan"
  tags = {
    Name = "${local.mytag}-this is from my-ami"
  }
}