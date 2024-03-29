resource "alicloud_ecs_key_pair" "publickey" {
  key_pair_name = "public_key"
  public_key    = var.ssh_public_key
}

resource "alicloud_resource_manager_resource_group" "open-initiative-lab" {
  resource_group_name = "open-initiative-lab"
  display_name        = "open-initiative-lab"
}


