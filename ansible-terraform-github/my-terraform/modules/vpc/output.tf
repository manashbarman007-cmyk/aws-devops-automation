output "vpc_id" {
  description = "The ID of the VPC"
  value = module.vpc.vpc_id
}

output "public_subnet" {
  description = "The public subnet"
  value = module.vpc.public_subnets[0]
}

output "private_subnet" {
  description = "The private subnet"
  value = module.vpc.private_subnets[0]
}

output "private_subnets" {
  description = "The private subnets"
  value = module.vpc.private_subnets
}
