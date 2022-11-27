locals {
  container_url = "ghcr.io/crushten/go_endpoint_cloud:v0.2.0-amd64"

  cluster_name = "demo-eks-${random_string.suffix.result}"

}