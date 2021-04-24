resource "aws_instance" "example" {
  ami              = lookup(var.AMIS, var.AWS_REGION)
  instance_type    = var.name
# for VPC subnet
  subnet_id        = aws_subnet.main-public-2.id
# # for Public key
#   key_name         = var.key
# for Sg
  security_groups  = [aws_security_group.allow-ssh-login.id]
  tags = {
    Name = "elite-vm"
  }
}
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = var.deployer-key
}