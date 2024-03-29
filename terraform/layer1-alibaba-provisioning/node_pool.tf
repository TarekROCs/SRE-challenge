resource "alicloud_cs_kubernetes_node_pool" "open-initiative-lab-1" {
  name                  = var.open-initiative-lab_node_pool_name_1
  cluster_id            = alicloud_cs_managed_kubernetes.open-initiative-lab-management-cluster.id
  resource_group_id     = alicloud_resource_manager_resource_group.open-initiative-lab.id
  vswitch_ids           = [alicloud_vswitch.open-initiative-lab_node_vswitches.0.id]
  install_cloud_monitor = false

  instance_types       = var.worker_instance_types
  image_type           = var.worker_os_image
  desired_size         = var.number_of_workers_1
  instance_charge_type = "PostPaid"
  key_name             = alicloud_ecs_key_pair.publickey.key_pair_name

  runtime_name    = "containerd"
  runtime_version = "1.6.20"

  system_disk_category          = "cloud_essd"
  system_disk_performance_level = "PL0"
  system_disk_size              = 40

  tags = {
    App_Service : "open-initiative-lab",
    Env : "Prod",
    Technical_Owner : "DevOps",
    Business_Owner : "Product Engineering",
    Version : 0.1
  }
}

resource "alicloud_cs_kubernetes_node_pool" "open-initiative-lab-2" {
  name                  = var.open-initiative-lab_node_pool_name_2
  cluster_id            = alicloud_cs_managed_kubernetes.open-initiative-lab-management-cluster.id
  resource_group_id     = alicloud_resource_manager_resource_group.open-initiative-lab.id
  vswitch_ids           = [alicloud_vswitch.open-initiative-lab_node_vswitches.1.id]
  install_cloud_monitor = false

  instance_types       = var.worker_instance_types
  image_type           = var.worker_os_image
  desired_size         = var.number_of_workers_2
  instance_charge_type = "PostPaid"
  key_name             = alicloud_ecs_key_pair.publickey.key_pair_name

  runtime_name    = "containerd"
  runtime_version = "1.6.20"

  system_disk_category          = "cloud_essd"
  system_disk_performance_level = "PL0"
  system_disk_size              = 40

  tags = {
    App_Service : "open-initiative-lab",
    Env : "Prod",
    Technical_Owner : "DevOps",
    Business_Owner : "Product Engineering",
    Version : 0.1
  }
}

resource "alicloud_cs_kubernetes_node_pool" "open-initiative-lab-3" {
  name                  = var.open-initiative-lab_node_pool_name_3
  cluster_id            = alicloud_cs_managed_kubernetes.open-initiative-lab-management-cluster.id
  resource_group_id     = alicloud_resource_manager_resource_group.open-initiative-lab.id
  vswitch_ids           = [alicloud_vswitch.open-initiative-lab_node_vswitches.2.id]
  install_cloud_monitor = false

  instance_types       = var.worker_instance_types
  image_type           = var.worker_os_image
  desired_size         = var.number_of_workers_3
  instance_charge_type = "PostPaid"
  key_name             = alicloud_ecs_key_pair.publickey.key_pair_name

  runtime_name    = "containerd"
  runtime_version = "1.6.20"

  system_disk_category          = "cloud_essd"
  system_disk_performance_level = "PL0"
  system_disk_size              = 40

  tags = {
    App_Service : "open-initiative-lab",
    Env : "Prod",
    Technical_Owner : "DevOps",
    Business_Owner : "Product Engineering",
    Version : 0.1
  }
}