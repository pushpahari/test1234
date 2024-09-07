# # Define the EFS file system
# resource "aws_efs_file_system" "efs" {
#   creation_token = "eks-efs"
#   encrypted      = true
#   tags = {
#     Name = "${var.project_name}-efs"
#   }
# }

# # Define mount targets for EFS in private subnets
# resource "aws_efs_mount_target" "efs_mount" {
#   count           = length(var.private_subnet_cidrs)
#   file_system_id  = aws_efs_file_system.efs.id
#   subnet_id       = element(aws_subnet.private_subnets[*].id, count.index)
#   security_groups = [aws_security_group.efs_sg.id]
# }