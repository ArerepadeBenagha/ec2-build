# Vars.tf
variable "AWS_ACCESS_KEY"  {}
variable "AWS_SECRET_KEY"  {}
variable "AWS_REGION" {
  default = "us-east-1"
}
variable "AMIS" {
  type =  map
  default = {
    us-east-1 = "ami-07957d39ebba800d5"
    us-west-1 = "ami-0a40aea49c501581d"
  }
}

variable "name" {
  description = "size of ec2"
  default     = "t2.micro"
}

variable "path_to_public_key" {
  description = "public key"
  default     = "mykey.pub"
}

variable "path_to_private_key" {
  description = "private key"
  default     = "mykey"
}

variable "key_name" {
  description = "Key name for SSHing into EC2"
  default = "mykeypair"
}