output "public_ips" {
  value = aws_instance.spark_nodes[*].public_ip
}

output "private_ips" {
  value = aws_instance.spark_nodes[*].private_ip
}