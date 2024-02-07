variable "ec2_name" {         # bu satirlar variables.tf dosyasi olarak oraya kaydedildi. 
  default = "jonas-ec2"
}

variable "ec2_type" {
  default = "t2.micro"
}

variable "ec2_ami" {
  default = "ami-0277155c3f0ab2930"
}

variable "number_of_buckets" {
 default     = 2
  
}

variable "s3_bucket_name" {
  default = "new-jonas-bucket"
  
}

variable "users" {
  default = ["santino", "michael", "fredo"]
}

