# # Define the security group for EKS nodes
# resource "aws_security_group" "eks_nodes" {
#   vpc_id = aws_vpc.eks.id

#   # Ingress rules to allow traffic from EKS nodes
#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # Egress rules to allow traffic to anywhere
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "${var.project_name}-nodes-sg"
#   }
# }

# # Define the security group for EFS
# resource "aws_security_group" "efs_sg" {
#   vpc_id = aws_vpc.eks.id

#   # Ingress rules to allow traffic from EKS nodes
#   ingress {
#     from_port       = 2049
#     to_port         = 2049
#     protocol        = "tcp"
#     security_groups = [aws_security_group.eks_nodes.id]
#   }

#   # Egress rules to allow traffic to anywhere
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "${var.project_name}-efs-sg"
#   }
# }