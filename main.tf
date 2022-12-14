module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.31.2"

  cluster_name    = local.cluster_name
  cluster_version = "1.24"

  subnet_ids = module.vpc.private_subnets
  vpc_id     = module.vpc.vpc_id

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"

    attach_cluster_primary_security_group = true

    create_launch_template = false
    launch_template_name   = ""

    enabled_cluster_log_types = ["api", "authenticator", "audit", "scheduler", "controllerManager"]

    endpoint_public_access = false
  }

  eks_managed_node_groups = {
    one = {
      name                   = "eks_managed_node_1"
      instance_type          = "t2.small"
      min_size               = 1
      max_size               = 1
      desired_size           = 1
      vpc_security_group_ids = [aws_security_group.eks_managed_node_group_one.id]
    }
    #  two = {
    #     name                          = "eks_managed_node_2"
    #    instance_type                 = "t3.medium"
    #    min_size     = 1
    #    max_size     = 2
    #    desired_size = 1
    #     vpc_security_group_ids = [aws_security_group.eks_managed_node_group_two.id]
    #  }
  }

}