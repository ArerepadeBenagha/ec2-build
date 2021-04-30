terraform {
  backend "s3" {
    bucket = "terraform-state-fc4c"
    key    = "state-file"
    region = "us-east-1"
  }
}