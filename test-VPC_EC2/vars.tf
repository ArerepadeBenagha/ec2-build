variable "aws_access_key"  {}
variable "aws_secret_key"  {}
variable "aws_region" {
  default = "us-east-1"
}

variable "amis" {
  type =  map
  default = {
    us-east-1 = "ami-048f6ed62451373d9"   ## "ami-07957d39ebba800d5"
    us-west-1 = "ami-0ff8a91507f77f867"   ## "ami-0a40aea49c501581d"
  }
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

variable "instance_tags" {
  type = list
  default = ["elite-vm-master", "elite-vm-agent"]
}

variable "instance_type" {
  default = "t2.micro"
}