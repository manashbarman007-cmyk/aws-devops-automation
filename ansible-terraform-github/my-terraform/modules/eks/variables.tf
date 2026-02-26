variable "ami_type" {
  description = "The AMI type for the worker nodes"
  type = string
  default = "AL2023_x86_64_STANDARD"
}

variable "ec2_instance_type" {
  description = "The EC2 instance type for the worker nodes"
  type = string
  default = "c7i-flex.large"    
}

variable "vpc_id" {
  description = "The ID of the VPC where the EKS cluster will be deployed"
  type = string
}

variable "private_subnets" {
  description = "A list of private subnet IDs where the EKS worker nodes will be deployed"
  type = list(string)
}

variable "private_ec2_sg_id"  {
  description = "The security group ID of the private EC2 instance (Jenkins) that needs access to EKS API"
  type = string
}

variable "private_ec2_iam_role_arn" {
  description = "The ARN of the IAM role for the private EC2 instance (Jenkins) to access EKS API"
  type = string
}