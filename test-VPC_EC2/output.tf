output "app-ip" {
  value = [aws_instance.elite-vm.*.public_ip]
}
