# Define the EC2 Key Pair name to use for SSH access
variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
}

# Define the path to your private key for SSH access
variable "private_key_path" {
  description = "Path to your private key"
  type        = string
}

# Define the AWS region where resources will be provisioned
variable "aws_region" {
  default     = "us-east-1"
  description = "AWS region where resources will be provisioned"
}

# Define the AMI ID for the EC2 instance
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-084568db4383264d4"
}

# Define the instance type for the EC2 instance
variable "instance_type" {
  description = "Instance type for the EC2 instance"
  default     = "t2.medium"
}

# Define the environment for the EC2 instance (e.g., dev, prod)
variable "my_enviroment" {
  description = "Environment for the EC2 instance"
  default     = "dev"
}
