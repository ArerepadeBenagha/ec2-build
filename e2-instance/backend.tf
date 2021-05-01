terraform {
 backend "s3" {
   bucket = "terraform-state-745dgc"
   key    = "ec2instance-state"
   region = "us-east-1"
 }
}