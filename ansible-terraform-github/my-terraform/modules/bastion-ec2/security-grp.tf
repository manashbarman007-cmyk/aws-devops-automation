# Security group to allow SSH access and HTTP access to the instance
resource "aws_security_group" "bastion_security_group" {
  name        = "bastion-sg"
  description = "This will add a TF generated security group for Bastion EC2 instance"
  vpc_id      = var.vpc_id # Interpolation to get the VPC ID

  # inbound rules (defined by ingress)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.bastion_cidr_blocks # allow SSH from anywhere (not recommended for production)
    description = "Allow SSH access"
  }
  
  # outbound rules (it is defined by egress)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # all protocols
    cidr_blocks = ["0.0.0.0/0"] # allow all outbound traffic (not recommended for production)
    description = "Allow all outbound traffic" 
  }
  
  tags = {
    Name = "bastion-sg"
  }
  
}