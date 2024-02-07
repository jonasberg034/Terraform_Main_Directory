module "tf-vpc" {
  source = "../modules"
  environment = "DEV"               # bunun altina degistirmek istedigimiz varaibles i giriyoruz.
  }

output "vpc-cidr-block" {
  value = module.tf-vpc.vpc_cidr
}