variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
}

variable "private_key_path" {
  description = "Path to your private key"
  type        = string
}


variable "aws_region" {
  default     = "us-east-1"
  description = "AWS region where resources will be provisioned"

}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-084568db4383264d4"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  default     = "t2.medium"
}

variable "my_enviroment" {
  description = "Instance type for the EC2 instance"
  default     = "dev"
}
