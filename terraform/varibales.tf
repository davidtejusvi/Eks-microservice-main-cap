variable "region" {
  description = "AWS region to deploy"
  type        = string
  default     = "ap-south-1"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "ekswithdavid"
}

variable "kubernetes_version" {
  description = "kubenetes control plane version"
  type        = string
  default     = "1.35"
}

variable "vpc_cidr" {
  description = "CIDR block of VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_types" {
  description = "instance type"
  type        = list(string)
  default     = ["c7i-flex.large"]
}

variable "desired_size" {
  description = "number of worker nodes"
  type        = number
  default     = 2
}
