terraform {
  backend "s3" {
    bucket = "terraform-state-fc4c"
    key    = "terraform/test-VPC_EC2"
    region = "us-east-1"
  }
}