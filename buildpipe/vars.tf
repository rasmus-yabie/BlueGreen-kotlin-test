variable "AWS_ACCESS_KEY" { type = string }
variable "AWS_SECRET_KEY" { type = string }
variable "AWS_REGION" {
  type    = string
  default = "eu-north-1"
}
variable "cidr" { type = string }
variable "private_subnets" { type = list(string) }
variable "public_subnets" { type = list(string) }
variable "availability_zones" { type = list(string) }
variable "environment" { 
  type = string 
  default = "dev"
}
