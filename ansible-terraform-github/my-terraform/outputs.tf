output "bastion_public_ip" {
  description = "The public IP of the Bastion"
  value = module.create_bastion_ec2.bastion_details
}

output "private_ec2_ip" {
  description = "The private IP of the Private EC2 instance"
  value = module.create_private_ec2.private_details
}

output "bastion_security_group_id" {
  description = "The security group ID of the Bastion instance"
  value = module.create_bastion_ec2.bastion_sg_id
}