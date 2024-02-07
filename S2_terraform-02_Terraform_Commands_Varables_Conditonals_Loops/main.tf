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

resource "aws_instance" "tf-ec2" {
  ami = "ami-0c7217cdde317cfec"
  # ami           = "ami-0277155c3f0ab2930"
  instance_type = "t2.micro"
  key_name      = "clarusway"
  tags = {
    # "Name" = "created-by-tf"
    "Name" = "tf-ec2-ubuntu"
  }
}

resource "aws_s3_bucket" "tf-s3" {
  bucket = "jonas-tf-bucket"

  tags = {
    Name        = "created-by-tf"
    Environment = "prod"
    # Environment = "Dev"
  }
}

output "tf-example-instance-public-id" {
  value = aws_instance.tf-ec2.public_ip

}

output "tf-example-s3-id" {
  value = "my bucket id is ${aws_s3_bucket.tf-s3.id}"

}

output "api_base_url" {
  value = "https://${aws_instance.tf-ec2.private_dns}:8433/"

}