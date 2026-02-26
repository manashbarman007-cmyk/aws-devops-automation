output "private_details" {
  description = "Private IP of the Private EC2 instance"
  value = aws_instance.private_instance.private_ip
}

output "private_sg_id" {
  description = "The security group ID of the private EC2 instance (Jenkins)"
  value = aws_security_group.private_security_group.id
}

output "iam_private_arn" {
  description = "The ARN of the IAM role for the private EC2 instance"
  value = aws_iam_role.admin_role.arn
}