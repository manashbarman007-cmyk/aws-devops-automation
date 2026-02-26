# Security group to allow SSH access and HTTP access to the instance
resource "aws_security_group" "private_security_group" {
  name        = "private-sg"
  description = "This will add a TF generated security group for Private EC2 instance"
  vpc_id      = var.vpc_id # Interpolation to get the VPC ID

  # inbound rules (defined by ingress) for ssh
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [var.bastion_sg_id] # allow SSH from the bastion security group
    description = "Allow SSH access"
  }

  # inbound rules (defined by ingress) for jenkins
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    security_groups = [var.bastion_sg_id] # allow SSH from the bastion security group
    description = "Allow Jenkins access"
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
    Name = "private-sg"
  }
  
}

# Allow all traffic from private EC2 instance SG to EKS worker nodes SG
resource "aws_security_group_rule" "allow_private_ec2_to_eks" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = var.eks_worker_nodes_sg_id # interpolation (allowing access from the private EC2 instance SG to the EKS worker nodes)
  source_security_group_id = aws_security_group.private_security_group.id
  description              = "Allow private EC2 instance to access EKS worker nodes"
}

# Allow all traffic from private EC2 instance SG to EKS API server SG 
resource "aws_security_group_rule" "private_ec2_to_eks_api" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"

  security_group_id        = var.eks_cluster_sg # interpolation (allowing access from the private EC2 instance SG to the EKS API server SG)
  source_security_group_id = aws_security_group.private_security_group.id

  description = "Allow private EC2 to access EKS API"
}