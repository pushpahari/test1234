terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.65.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.32.0"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.9.4"
    }
  }
  backend "s3" {
    bucket = "eks-backend"
    key    = "backend/terraform.tfstate"
    region = "ap-south-1"
    #dynamodb_table = "my-terraform-lock-table"
    encrypt = true
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}

provider "kubernetes" {
  host                   = aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks.certificate_authority[0].data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", aws_eks_cluster.eks.name]
  }
}

provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.eks.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.eks.name]
      command     = "aws"
    }
  }
}

