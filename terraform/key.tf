# Define an AWS key pair resource for instance access
resource "aws_key_pair" "instance_key" {
  key_name   = "instance_key"
  public_key = file(var.private_key_path)
}
