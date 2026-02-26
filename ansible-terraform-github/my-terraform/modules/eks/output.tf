output "worker_nodes_sg_id" {
    description = "The security group ID of the EKS worker nodes"
    value = aws_security_group.eks_worker_nodes_sg.id
}

output "cluster_sg_id" {
    description = "The security group ID of the EKS API server"
    value = module.eks.cluster_security_group_id
}