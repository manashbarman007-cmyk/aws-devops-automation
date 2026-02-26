resource "aws_instance" "bastion_instance" {

  # To use the key pair we created, we need to reference it using interpolation. 
  key_name = aws_key_pair.key_pair.key_name # Interpolation to get the key pair name

  # the Security Groups are provided in a list, so we need to use square brackets to create a list with one element
  vpc_security_group_ids = [aws_security_group.bastion_security_group.id] # Interpolation to get the security group ID  

  # ami for Ubuntu (64-bit (x86)) ap-south-1 region 
  ami           = "ami-019715e0d74f695be"

  instance_type = var.instance_type

  iam_instance_profile = aws_iam_instance_profile.admin_profile.name # Interpolation to get the IAM instance profile name


  subnet_id = var.public_subnet  # module.vpc.public_subnets[0] Interpolation to get the first public subnet ID from the VPC module

  # run the script 
  user_data = file("${path.module}/script.sh")

  associate_public_ip_address = true # Ensure the instance gets a public IP address

  # Storage (EBS)
  root_block_device {
    volume_size = 10 # Size in GB
    volume_type = "gp3" # General Purpose SSD
  }

  tags = {
    Name = "bastion-instance"
  }
}
