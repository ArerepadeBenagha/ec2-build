output "app-ip" {
  value = [aws_instance.example.*.public_ip]
}
