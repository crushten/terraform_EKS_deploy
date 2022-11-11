terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.23.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.12.1"
    }

    docker = {
      source  = "kreuzwerker/docker"
      version = "2.20.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.0"
    }
  }

  required_version = ">= 0.13.1"
}