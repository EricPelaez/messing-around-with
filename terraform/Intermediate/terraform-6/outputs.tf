output "Web-link" {
  value = "http://${aws_instance.myserver.public_ip}"
}