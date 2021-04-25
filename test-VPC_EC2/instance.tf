resource "aws_instance" "example" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = var.name

# for VPC subnet
  subnet_id = aws_subnet.main-public-1.id

# the public SSH key
  key_name = aws_key_pair.mykeypair.key_name

# for Sg
  security_groups  = [aws_security_group.allow-ssh-login.id]
  tags = {
    Name = "elite-vm"
  }
}