terraform {
 backend "s3" {
   bucket = "terraform-state-689defi"
   key    = "ec2instance-state"
   region = "us-east-1"
 }
}