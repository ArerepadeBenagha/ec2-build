# Vars.tf
variable "AWS_ACCESS_KEY"  {}
variable "AWS_SECRET_KEY"  {}
variable "AWS_REGION" {
  default = "us-east-1"
}
variable "AMIS" {
  type =  map
  default = {
    us-east-1 = "ami-0be2609ba883822ec"
  }
}
# variable "public_key_path" {
#   description = "Enter the path to the SSH Public Key to add to AWS."
#   default = "/c/Users/lbena/OneDrive/Documents/DevOps Lecture/Terraform-course-pratice/test-VPC_EC2"
# }

variable "key_name" {
  description = "Key name for SSHing into EC2"
  default = "/c/Users/lbena/OneDrive/Documents/DevOps Lecture/Terraform-course-pratice/test-VPC_EC2"
}
variable "name" {
  description = "size of ec2"
  default = "t2.micro"
}