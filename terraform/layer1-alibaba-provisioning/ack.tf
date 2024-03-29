resource "alicloud_cs_managed_kubernetes" "open-initiative-lab-management-cluster" {
  name                 = var.ack_cluster_name
  resource_group_id    = alicloud_resource_manager_resource_group.open-initiative-lab.id
  cluster_spec         = var.ack_cluster_spec
  worker_vswitch_ids   = split(",", join(",", alicloud_vswitch.elastic_node_vswitches.*.id))
  pod_vswitch_ids      = split(",", join(",", alicloud_vswitch.elastic_pod_vswitches.*.id))
  service_cidr         = var.ack_service_cidr
  security_group_id    = alicloud_security_group.open-initiative-lab-management-cluster.id
  new_nat_gateway      = false
  enable_rrsa          = true
  slb_internet_enabled = false
  deletion_protection  = false

  dynamic "addons" {
    for_each = var.cluster_addons
    content {
      name     = lookup(addons.value, "name", var.cluster_addons)
      config   = lookup(addons.value, "config", var.cluster_addons)
      disabled = lookup(addons.value, "disabled", var.cluster_addons)
    }
  }

  tags = {
    App_Service : "open-initiative-lab Kube Management",
    Env : "Prod",
    Technical_Owner : "DevOps",
    Business_Owner : "Product Engineering",
    Version : 0.1
  }
}




