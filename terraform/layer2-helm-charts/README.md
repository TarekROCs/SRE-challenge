# Terraform Helm chart Template

This Terraform template allows you to create and manage sealed secrets and traefik helm charts using terraform helm provider.

## Prerequisites

Before you begin, make sure you have the following installed:

- [Terraform](https://www.terraform.io/downloads.html) (v1.5.4 or later)

## Setup

1. **Clone the Repository:**
2. **Initialize Terraform:**

    ```bash
    terraform init
    ```

3. **Required provider:**

    Check the `provider.tf`:

    ```hcl
    terraform {
        required_providers {
            helm = {
                source  = "hashicorp/helm"
                version = "2.10.1"
            }
            alicloud = {
                source  = "hashicorp/alicloud"
                version = "1.213.0"
            }
        }
    }
    provider "helm" {
        kubernetes {
            config_path = "./configurations/kubeconfig"
            proxy_url   = join("", ["http://${var.tinyproxy_username}:${var.tinyproxy_password}@", "${data.alicloud_instances.bastions.instances.0.public_ip}", ":8888"])
        }
    }

    provider "alicloud" {
        access_key = var.access_key
        secret_key = var.secret_key
        region     = var.region
    }
    ```
Update the access_key, secret_key and region.

## Configuration

Create a file called variables.tfvars and adjust it to customize your ACK cluster. Define variables like the number of worker nodes, instance types, and other settings.

```hcl
######################
# PROVIDER
######################
variable "access_key" {
  description = "the used alibaba account access key"
  type        = string
}

variable "secret_key" {
  description = "the used alibaba account access key"
  type        = string
}

variable "region" {
  description = "the region where the infrastructure will be deployed"
  type        = string
}

######################
# BASTION | TINY PROXY
######################
variable "tinyproxy_username" {
  description = "tinyproxy username"
  type        = string
}

variable "tinyproxy_password" {
  description = "tinyproxy password"
  type        = string
}

######################
# Global variables
######################
variable "kubeconfig_path" {
  description = "Path to the file to check"
  type        = string
  default     = "./configurations/kubeconfig"
}
```
