resource "random_string" "suffix" {
  length  = 8
  special = false
}

variable "region" {
  default     = "us-east-2"
  description = "AWS region"
  type        = string
}

variable "appname" {
  default     = "go_endpoint_cloud"
  description = "Name of application"
  type        = string
}