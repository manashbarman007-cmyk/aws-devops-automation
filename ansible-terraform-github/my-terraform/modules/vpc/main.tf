module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc" 
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  
  tags = {
    Terraform = "true"
    Environment = "prod"
    "kubernetes.io/cluster/my-k8s-cluster" = "shared" # This tag is important for EKS to recognize the VPC and its subnets as part of the cluster's infrastructure
  }
}