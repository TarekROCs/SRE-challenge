# Terraform Alibaba ACK Template

This Terraform template allows you to create and manage Alibaba ACK clusters on Alibaba Cloud. It uses the Alibaba Cloud provider for Terraform.

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
            alicloud = {
                source  = "hashicorp/alicloud"
                version = "1.213.0"
            }
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
# ACK
######################
variable "ack_cluster_name" {
  description = "The name used to create managed kubernetes cluster."
  type        = string
}

variable "ack_cluster_spec" {
  description = "The cluster Spec."
  type        = string
}

variable "ack_service_cidr" {
  description = "The kubernetes service cidr block. It cannot be equals to vpc's or vswitch's or pod's and cannot be in them."
  type        = string
}

######################
# NODE_POOL
######################
variable "elastic_node_pool_name" {
  description = "The name used to create node pool."
  type        = string
}

variable "worker_instance_types" {
  description = "The ecs instance types used to launch worker nodes."
  type        = list(string)
}

variable "worker_os_image" {
  description = "Image used by workers"
  type        = string
}

variable "number_of_workers" {
  description = "desired number of workers"
  type        = number
}

variable "cluster_addons" {
  description = "the ack addons that needs to be enabled, or disabled"
  type = list(object({
    name     = string
    config   = string
    disabled = bool
  }))
}

######################
# NETWORK
######################
variable "vpc_name" {
  description = "The vpc name used to create a new vpc"
  type        = string
}

variable "vpc_cidr" {
  description = "The cidr block used to launch a new vpc."
  type        = string
}

variable "elastic_vswitch_name_prefix" {
  description = "The vswitch name prefix used to create several new vswitches"
  type        = string
}

variable "elastic_node_vswitch_cidrs" {
  description = "List of cidr blocks used to create several new vswitches"
  type        = list(string)
}

variable "elastic_pod_vswitch_cidrs" {
  description = "List of cidr blocks used to create several new vswitches"
  type        = list(string)
}

variable "availability_zones" {
  description = "The availability zones of vswitches."
  type        = list(string)
}

variable "default_name" {
  description = "The name as prefix used to create resources."
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

variable "ssh_public_key" {
  description = "the public key added to the bastion host and worker nodes"
  type        = string
}

variable "ssh_private_key_path" {
  description = "The path to ssh key pair private key. It includes the file name"
  type        = string
}

variable "ssh_username" {
  description = "username of the used key pairs"
  type        = string
}

######################
# Global variables
######################
variable "number_format" {
  description = "The number format used to output."
  type        = string
}

variable "kubeconfig_path" {
  description = "Path to the file to check"
  type        = string
}

######################
# Nat Gateway
######################
variable "elastic_nat_name_prefix" {
  description = "The nat name prefix used to create several nat."
  type        = string
}

variable "new_nat_gateway" {
  description = "Whether to create a new nat gateway, eip and server snat entries."
  type        = bool
}
```
