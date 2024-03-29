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
variable "open-initiative-lab_node_pool_name_1" {
  description = "The name used to create node pool."
  type        = string
}

variable "open-initiative-lab_node_pool_name_2" {
  description = "The name used to create node pool."
  type        = string
}

variable "open-initiative-lab_node_pool_name_3" {
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

variable "number_of_workers_1" {
  description = "desired number of workers"
  type        = number
}

variable "number_of_workers_2" {
  description = "desired number of workers"
  type        = number
}

variable "number_of_workers_3" {
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

variable "open-initiative-lab_vswitch_name_prefix" {
  description = "The vswitch name prefix used to create several new vswitches"
  type        = string
}

variable "open-initiative-lab_node_vswitch_cidrs" {
  description = "List of cidr blocks used to create several new vswitches"
  type        = list(string)
}

variable "open-initiative-lab_pod_vswitch_cidrs" {
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
variable "open-initiative-lab_nat_name_prefix" {
  description = "The nat name prefix used to create several nat."
  type        = string
}

variable "new_nat_gateway" {
  description = "Whether to create a new nat gateway, eip and server snat entries."
  type        = bool
}