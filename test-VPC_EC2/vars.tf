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

variable "deployer-key" {
  description = "Key name for SSHing into EC2"
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCsGmLdQLzVmtV8UxkMlprakks7+NOTjh0P7VS2t4BId7Ipb+tqzJknxfdI/yaPR2APGPROU+f5dtwP5IXEP87BNvNhNsAZj6dpT5vzM4B5/aBUYSXk7l+0WZ+NOZsFegwo6+p5NO4aPe4aVdhaBbux3gg1011uEz6vPvm5OVyngMMER1DNcJdMG4ymL1C1GmXjKCtyWU79j8weONQugw3zMdKMWZyjU5JA37ZHO2aV6i4mKuuXQqbh/ASG/UhU4i0w6mD6cUZ7l6VozRDKs5ZtlbcZWuBPB4Dt6qKd3ADUCm552qxsI8WbOuNWfzM+BUw5ZScam26hDjfhhjlSIFG44Pal5sKHOed0+GqOT/uAUV58TEYbF5TlCPfcXintEd36ZNKxzo2K+FKlBJWKy4I2v2R/FfNVsIvipJnOmEbKG76BcHu4ZYnhlr3U70Mt/8E78VPREH+YwPlS0nQvzmdgsOuDpA+T0+Ukwf7IVaTmspkDCibX8qgAyzhxvdl4kH8= lbena@LAPTOP-QB0DU4OG"
}
variable "name" {
  description = "size of ec2"
  default = "t2.micro"
}