# #Storage Class for EFS
# resource "kubernetes_storage_class" "efs_storage_class" {
#   metadata {
#     name = "efs-sc"
#   }

#   storage_provisioner = "efs.csi.aws.com"
# }

# #Persistent Volume and Claim
# resource "kubernetes_persistent_volume" "efs_pv" {
#   metadata {
#     name = "efs-pv"
#   }

#   spec {
#     capacity = {
#       storage = "5Gi"
#     }
#     volume_mode                      = "Filesystem"
#     access_modes                     = ["ReadWriteMany"]
#     storage_class_name               = "efs-sc"
#     persistent_volume_reclaim_policy = "Retain"
#     persistent_volume_source {
#       csi {
#         driver        = "efs.csi.aws.com"
#         volume_handle = aws_efs_file_system.efs.id
#       }
#     }
#   }
# }

# resource "kubernetes_persistent_volume_claim" "efs_pvc" {
#   metadata {
#     name = "efs-pvc"
#   }

#   spec {
#     access_modes = ["ReadWriteMany"]
#     resources {
#       requests = {
#         storage = "5Gi"
#       }
#     }
#     storage_class_name = "efs-sc"
#   }
# }