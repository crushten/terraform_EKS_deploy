resource "aws_security_group" "eks_managed_node_group_one" {
  name_prefix = "eks_managed_node_group_one"
  description = "Allow inbound traffic to EKS from VPC CIDR"
  vpc_id      = module.vpc.vpc_id

  #checkov:skip=CKV2_AWS_5:This is assigned in main.tf

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Allow SSH on port 22"

    cidr_blocks = [
      "10.0.0.1/32",
    ]
  }
}

#resource "aws_security_group" "eks_managed_node_group_two" {
#  name_prefix = "eks_managed_node_group_two"
#  vpc_id      = module.vpc.vpc_id
#
#  ingress {
#    from_port = 22
#    to_port   = 22
#    protocol  = "tcp"
#
#    cidr_blocks = [
#      "192.168.0.0/16",
#    ]
# }
#}