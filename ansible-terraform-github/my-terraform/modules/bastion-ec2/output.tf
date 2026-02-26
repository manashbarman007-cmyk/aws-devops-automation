output "bastion_details" {
  description = "Public IP of Bastion EC2 instance"
  value = aws_instance.bastion_instance.public_ip
}

output "bastion_sg_id" {
  description = "The security group of the bastion instance"
  value = aws_security_group.bastion_security_group.id
}

output "key_name" {
  description = "The name of the key pair used for the bastion instance"
  value = aws_key_pair.key_pair.key_name
}
