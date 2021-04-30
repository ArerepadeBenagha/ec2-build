# Ec2-instance
resource "aws_instance" "example" {
  ami           = lookup(var.amis, var.aws_region)
  instance_type = var.instance_type
  count         = 2
  key_name      = aws_key_pair.mykeypair.key_name
  tags = {
    Name        = element(var.instance_tags, count.index)
  }
}
# Keypair
resource "aws_key_pair" "mykeypair" {
  key_name   = "mykeypair"
  public_key = file(var.path_to_public_key)
}