resource "aws_eip" "elite-eip" {
  instance = aws_instance.example[count.index].id
  count = 3
  vpc   = true
  tags = {
       Name = element(var.instance_eips, count.index)
  }
}

# eip attachment
resource "aws_eip_association" "eip_assoc" {
  count = 3
  instance_id   = aws_instance.example[count.index].id
  allocation_id = aws_eip.elite-eip[count.index].id
}