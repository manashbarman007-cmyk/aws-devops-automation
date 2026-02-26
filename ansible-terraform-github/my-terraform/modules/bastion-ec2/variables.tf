variable "bastion_cidr_blocks" {
  description = "Enter allowed public IPs to access Bastion"
  type = list(string)
}

variable "instance_type" {
    description = "Type of EC2 instance to launch"
    type = string
    default = "c7i-flex.large"
}

variable "vpc_id" {
  description = "The ID of the VPC where the Bastion host will be deployed"
  type = string
} 

variable "public_subnet" {
  description = "The ID of the public subnet where the Bastion host will be deployed"
  type = string
}
