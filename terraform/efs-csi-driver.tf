# # EFS CSI Driver Helm Release
# resource "helm_release" "efs_csi_driver" {
#   name       = "aws-efs-csi-driver"
#   repository = "https://kubernetes-sigs.github.io/aws-efs-csi-driver/"
#   chart      = "aws-efs-csi-driver"
#   namespace  = "kube-system"
#   version    = "2.4.1"

#   set {
#     name  = "image.repository"
#     value = "602401143452.dkr.ecr.${var.region}.amazonaws.com/eks/aws-efs-csi-driver"
#   }

#   set {
#     name  = "controller.serviceAccount.create"
#     value = "true"
#   }

#   set {
#     name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
#     value = aws_iam_role.efs_csi_driver_role.arn
#   }

#   depends_on = [aws_iam_role_policy_attachment.attach_policy]
# }