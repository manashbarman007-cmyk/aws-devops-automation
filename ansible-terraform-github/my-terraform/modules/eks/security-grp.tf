resource "aws_security_group" "eks_worker_nodes_sg" {
  name        = "my-k8s-cluster-worker-nodes-sg"
  description = "Security group for EKS worker nodes"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "my-k8s-cluster-worker-nodes-sg"
    Environment = "dev"
    Terraform   = "true"
  }
}

# Allow all traffic from EKS worker nodes SG to private EC2 instance SG
resource "aws_security_group_rule" "allow_eks_to_private_ec2" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = var.private_ec2_sg_id # interpolation (allowing access from the private EC2 instance SG to the EKS worker nodes)
  source_security_group_id = aws_security_group.eks_worker_nodes_sg.id
  description              = "Allow all traffic from EKS worker nodes SG to private EC2 instance SG"
}