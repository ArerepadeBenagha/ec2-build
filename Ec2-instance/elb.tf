# # Create a new load balancer
# resource "aws_elb" "bar" {
#   source = "../modules/elb"
#   name               = "foobar-terraform-elb"
#   availability_zones = ["us-east-2a", "us-east-2b", "us-east-2c"]
#   instances          = [aws_instance.foo.id]
# }
