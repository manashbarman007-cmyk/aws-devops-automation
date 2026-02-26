module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "my-k8s-cluster"
  kubernetes_version = "1.33"

  # Optional
  endpoint_public_access = false # for private EKS cluster, we disable public access to the API server endpoint

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  endpoint_private_access = true # for private EKS cluster, we enable private access to the API server endpoint

  # we need to allow the private EC2 instance (Jenkins) to access the EKS API, 
  # so we add an additional security group rule to the worker node security group 
  # to allow all traffic from the private EC2 instance security group
  node_security_group_additional_rules = {
    ec2_access = {
      description = "Allow all traffic from private EC2 instance SG to worker nodes"
      protocol = "-1"
      from_port = 0
      to_port = 0
      type = "ingress"
      source_security_group_id = var.private_ec2_sg_id # interpolation (allowing access from the private EC2 instance SG to the EKS worker nodes)
    }
  }

  addons = {
    coredns                = { most_recent = true }
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy             = { most_recent = true }
    vpc-cni                = {
      before_compute = true
    }
  }

  vpc_id                   = var.vpc_id # interpolation
  subnet_ids               = var.private_subnets # interpolation (worker nodes will be created in private subnets)
  control_plane_subnet_ids = var.private_subnets # interpolation (EKS control plane ENIs will be created in private subnets)
  
  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    worker_nodes = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = var.ami_type
      instance_types = [var.ec2_instance_type]

      min_size     = 2
      max_size     = 5
      desired_size = 3 # we will have 3 worker nodes in the node group when we apply this configuration
    }
  }

  # This will allow the private EC2 instance to have admin to the EKS cluster by associating the AmazonEKSClusterAdminPolicy with the specified IAM role (ec2-admin-role) for the cluster access entry named "private-ec2". This is necessary for Jenkins to be able to interact with the EKS cluster and manage it effectively.
  access_entries = {
  private-ec2 = {
    principal_arn = var.private_ec2_iam_role_arn # interpolation to get the IAM role ARN for the private EC2 instance (Jenkins)

    policy_associations = {
      admin = {
        policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

        access_scope = {
          type = "cluster"
        }
      }
    }
  }
}

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}