module "create_bastion_ec2" {
  source = "./modules/bastion-ec2"
  bastion_cidr_blocks = ["0.0.0.0/0"]
  vpc_id = module.create_vpc.vpc_id
  public_subnet = module.create_vpc.public_subnet # Interpolation to get the first public subnet ID from the VPC module
}

module "create_private_ec2" {
  source = "./modules/private-ec2"
  eks_cluster_sg = module.create_eks.cluster_sg_id # Interpolation to get the security group ID of the EKS API server SG from the EKS module
  vpc_id = module.create_vpc.vpc_id
  bastion_sg_id = module.create_bastion_ec2.bastion_sg_id
  eks_worker_nodes_sg_id = module.create_eks.worker_nodes_sg_id # Interpolation to get the security group ID of the EKS worker nodes SG from the EKS module
  private_subnet = module.create_vpc.private_subnet # Interpolation to get the first private subnet ID from the VPC module
  key_pair_name = module.create_bastion_ec2.key_name # Interpolation to get the key pair name from the Bastion EC2 module
}

module "create_vpc" {
  source = "./modules/vpc"
}

module "create_eks" {
  source = "./modules/eks"
  vpc_id = module.create_vpc.vpc_id # interpolation
  private_ec2_iam_role_arn = module.create_private_ec2.iam_private_arn # interpolation to get the IAM role ARN for the private EC2 instance (Jenkins) from the Private EC2 module
  private_subnets = module.create_vpc.private_subnets # interpolation (worker nodes will be created in private subnets)
  private_ec2_sg_id = module.create_private_ec2.private_sg_id # interpolation to get the security group ID of the private EC2 instance (Jenkins)
}

