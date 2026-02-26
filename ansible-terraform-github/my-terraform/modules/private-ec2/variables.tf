variable "instance_type" {
    description = "Type of EC2 instance to launch"
    type = string
    default = "c7i-flex.large"
}

variable "vpc_id" {
  description = "The ID of the VPC where the Private EC2 instance will be deployed"
  type = string
}

variable "bastion_sg_id" {
  description = "The ID of the Bastion security group to allow SSH access from the Bastion host"
  type = string
  
}

variable "private_subnet" {
  description = "The private subnet where the private EC2 will be deployed"
  type = string
}

variable "key_pair_name" {
  description = "The name of the key pair to use for the private EC2 instance"
  type = string
}

variable "eks_worker_nodes_sg_id" {
  description = "The security group ID of the EKS worker nodes SG to allow access from the private EC2 instance SG"
  type = string
}

variable "eks_cluster_sg" {
  description = "The security group ID of the EKS API server SG to allow access from the private EC2 instance SG"
  type = string
}