# Define the AWS provider configuration with region from the variable
provider "aws" {
  region = var.aws_region
}

# Create a VPC with a CIDR block of 10.0.0.0/16
resource "aws_vpc" "default" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

# Create an internet gateway to allow traffic from the internet to the VPC
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "main-gateway"
  }
}

# Create a route table to route all outbound traffic (0.0.0.0/0) to the internet gateway
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Create a subnet within the VPC, assigning a specific CIDR block (10.0.1.0/24)
resource "aws_subnet" "main_subnet" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

# Associate the public route table with the subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Create a security group to allow SSH and Spark ports (8080, 7077, 7078, 4040)
resource "aws_security_group" "spark_sg" {
  name        = "spark-security-group"
  description = "Allow SSH and Spark ports"
  vpc_id      = aws_vpc.default.id

  # Allow SSH access (port 22) from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow Spark UI access (port 8080) from anywhere
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow Spark master port (7077) from anywhere
  ingress {
    from_port   = 7077
    to_port     = 7077
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow Spark worker port (7078) from anywhere
  ingress {
    from_port   = 7078
    to_port     = 7078
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow Spark Web UI access (port 4040) from anywhere
  ingress {
    from_port   = 4040
    to_port     = 4040
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow egress traffic (any port) to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create EC2 instances for Spark nodes (5 total, one master and 4 slaves)
resource "aws_instance" "spark_nodes" {
  count                  = 5
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.instance_key.key_name
  subnet_id              = aws_subnet.main_subnet.id
  vpc_security_group_ids = [aws_security_group.spark_sg.id]

  # Tag the first instance as the master, and the others as slaves
  tags = {
    Name = count.index == 0 ? "spark-master" : "spark-slave-${count.index}"
  }
}
