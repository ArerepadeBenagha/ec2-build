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
variable "public_key_path" {
  description = "Enter the path to the SSH Public Key to add to AWS."
  default = "/root/Gurus_merchandise.pem"
}

variable "key_name" {
  description = "Key name for SSHing into EC2"
  default = "mykey"
}
