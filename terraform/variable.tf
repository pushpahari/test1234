variable "project_name" {
  default = "eks"
}

variable "region" {
  default = "ap-south-1"
}


variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "azs" {
  type        = list(string)
  description = "availability zones"
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "public subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "private subnet CIDR values"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "new_relic_license_key" {
  description = "New Relic License Key"
  type        = string
  default     = "eu01xx6e7ede4009aa1ff7a86f07714dFFFFNRAL"
}

variable "cluster_name" {
  description = "Name of the EKS Cluster"
  type        = string
  default     = "eks-cluster"
}
