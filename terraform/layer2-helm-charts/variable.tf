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