terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.23.0"
    }
  }
}

provider "kubernetes" {
  config_path    = "./configurations/kubeconfig"
  proxy_url      = join("", ["http://kube:kube@",  "${data.terraform_remote_state.alibaba_infrastructure_state.outputs.bastion_ip}", ":8888"])
}