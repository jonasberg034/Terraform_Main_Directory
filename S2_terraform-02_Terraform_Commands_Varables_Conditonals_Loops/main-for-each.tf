terraform { # Bu blok olmadan da bu dosya calisirdi. 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.35.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

# variable "ec2_name" {         # bu satirlar variables.tf dosyasi olarak oraya kaydedildi. 
#   default = "jonas-ec2"
# }

# variable "ec2_type" {
#   default = "t2.micro"
# }

# variable "ec2_ami" {
#   default = "ami-0277155c3f0ab2930"
# }

locals {
  mytag = "jonas-local-name"
}

resource "aws_instance" "tf-ec2" {
  ami           = var.ec2_ami
  instance_type = var.ec2_type
  key_name      = "clarusway"
  tags = {
    "Name" = "${local.mytag}-come from locals"   # "${var.ec2_name}-instance"     # local eklendigi icin bu satir yorm satiri olarak alindi.
}
}

resource "aws_s3_bucket" "tf-s3" {
  for_each = toset(var.users)
  bucket   = "${var.s3_bucket_name}-${each.value}"
  
  tags = {
    Name        =  "${local.mytag} come from locals"                               # "created-by-tf"  # Locals eklendi.
    Environment = "Dev"
  }
}

resource "aws_iam_user" "new_users" {
  for_each = toset(var.users)
  name = each.value
}

output "uppercase_users" {
  value = [for user in var.users : upper(user) if length(user) > 6]
}

output "tf-example-instance-public-id" {
  value = aws_instance.tf-ec2.public_ip

}


output "api_base_url" {
  value = "https://${aws_instance.tf-ec2.private_dns}:8433/"

}

output "instance-name" {
  value       = "my instance name is ${var.ec2_name}-instance"
}
