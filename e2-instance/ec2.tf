# Ec2-instance
resource "aws_instance" "example" {
  ami           = lookup(var.amis, var.aws_region)
  instance_type = var.instance_type
  count         = var.instance_count
  subnet_id = aws_subnet.main-public-1.id
  key_name      = aws_key_pair.mykeypair.key_name
  vpc_security_group_ids = [aws_security_group.example-instance.id]
  tags = {
    Name        = element(var.instance_tags, count.index)
  }
}
resource "aws_ebs_volume" "volume-new" {
  availability_zone = "${element(aws_instance.example.*.availability_zone, count.index)}"
  count             = "${var.instance_count * var.elite_ebs_volume_count}"
  size              = var.elite_ebs_volume_size
  type              = var.volume_type
  tags = {
    Name = "extra EBS volume data"
  }
}
resource "aws_volume_attachment" "ebs-volume-attachment" {
  count       = "${var.instance_count * var.elite_ebs_volume_count}"
  volume_id   = "${aws_ebs_volume.volume-new.*.id[count.index]}"
  device_name = "${element(var.elite-device-names, count.index)}"
  instance_id = "${element(aws_instance.example.*.id, count.index)}"
}