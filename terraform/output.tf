

# Output the public IP addresses of all the Spark nodes
output "public_ips" {
  value = aws_instance.spark_nodes[*].public_ip
}

# Output the private IP addresses of all the Spark nodes

output "private_ips" {
  value = aws_instance.spark_nodes[*].private_ip
}