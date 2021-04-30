# Ec2-instance
resource "aws_instance" "example" {
  ami           = lookup(var.amis, var.aws_region)
  instance_type = var.instance_type
  count         = 2
  subnet_id = aws_subnet.main-public-1.id
  key_name      = aws_key_pair.mykeypair.key_name
  vpc_security_group_ids = [aws_security_group.example-instance.id]
  tags = {
    Name        = element(var.instance_tags, count.index)
  }
}