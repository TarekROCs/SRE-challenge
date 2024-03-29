data "alicloud_slb_load_balancers" "traefik_slbs" {
  name_regex = "traefik"
  depends_on = [helm_release.traefik]
}

data "alicloud_instances" "bastions" {
  name_regex = "bastion"
}

data "alicloud_cs_managed_kubernetes_clusters" "open-initiative-lab-management-clusters" {
  name_regex = "open-initiative-lab-management-cluster"
}

data "alicloud_cs_cluster_credential" "auth" {
  cluster_id                 = data.alicloud_cs_managed_kubernetes_clusters.open-initiative-lab-management-clusters.clusters.0.id
  temporary_duration_minutes = 4320
  output_file                = var.kubeconfig_path
}

data "alicloud_eip_addresses" "eip_addresses" {
  name_regex = "open-initiative-lab-EIP"
}
