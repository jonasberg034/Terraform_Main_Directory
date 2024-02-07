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
  bucket = "jonas-new-bucket"   #"${var.s3_bucket_name}-${count.index}"      # best practice bu uygulanir. Bunu yazmaz isen terraform tfstate dosyasinda 0'dan baslayarak bir numara veriyor. Bu sekilde dha duzenli oluyor.
  # count =  var.number_of_buckets                                                  # variables dosyasina bak sayi icin.

  tags = {
    Name        =  "${local.mytag} come from locals"                               # "created-by-tf"  # Locals eklendi.
    Environment = "Dev"
  }
}

output "tf-example-instance-public-id" {
  value = aws_instance.tf-ec2.public_ip

}

# output "tf-example-s3-name" {
#   value = var.s3_bucket_name  #[*]

# }

output "api_base_url" {
  value = "https://${aws_instance.tf-ec2.private_dns}:8433/"

}

output "instance-name" {
  value = "my instance name is ${var.ec2_name}-instance"
}

output "s3_bucket_info" {
  value = {
    bucket_name = aws_s3_bucket.tf-s3.bucket
    arn         = aws_s3_bucket.tf-s3.arn
    region      = aws_s3_bucket.tf-s3.region
    domain_name = aws_s3_bucket.tf-s3.bucket_domain_name
    website_url = "http://${aws_s3_bucket.tf-s3.bucket}.s3.amazonaws.com/"
  }
}
