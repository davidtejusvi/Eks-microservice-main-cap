# output "cluster_name" {
#   description = "EKS cluster name"
#   value       = module.eks.cluster_name
# }

# output "cluster_endpoint" {
#   description = "End point of EKS cluster plane"
#   value       = module.eks.cluster_endpoint
# }

output "cluster_version" {
  description = "kubernetes version for control plane"
  value       = var.kubernetes_version
}

output "vpc_id" {
  description = "Vpc id of hosting the cluster"
  value       = module.vpc.vpc_id
}

output "configure_kubectl" {
  description = "command update your local kubeconfig"
  value       = "aws eks update-kubeconfig --region ${var.region} --name ${var.cluster_name}"
}
