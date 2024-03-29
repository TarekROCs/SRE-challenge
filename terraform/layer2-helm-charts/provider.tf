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