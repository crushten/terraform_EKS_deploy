
output "cluster_id" {
  description = "EKS cluster ID."
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name" {
  description = "Kubernetes cluster Name"
  value       = local.cluster_name
}

output "load_balancer_hostname" {
  description = "Kubernetes application hostname"
  value       = kubernetes_service.go.status.0.load_balancer.0.ingress.0.hostname
}