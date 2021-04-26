terraform {
  backend "s3" {
    bucket = "terraform-state-fc4c"
    key    = "terraform/my-bucket"
    region = "us-east-1"
  }
}