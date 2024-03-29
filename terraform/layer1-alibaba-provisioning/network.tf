resource "alicloud_vpc" "open-initiative-lab-prod" {
  vpc_name          = var.vpc_name
  cidr_block        = var.vpc_cidr
  resource_group_id = alicloud_resource_manager_resource_group.open-initiative-lab.id

  tags = {
    App_Service : "open-initiative-lab",
    Env : "Prod",
    Technical_Owner : "DevOps",
    Business_Owner : "Product Engineering",
    Version : 0.1
  }
}

resource "alicloud_vswitch" "open-initiative-lab_node_vswitches" {
  count      = length(var.open-initiative-lab_node_vswitch_cidrs)
  vpc_id     = alicloud_vpc.open-initiative-lab-prod.id
  cidr_block = element(var.open-initiative-lab_node_vswitch_cidrs, count.index)
  zone_id    = element(var.availability_zones, count.index)
  vswitch_name = format(
    "%s-node-%s",
    var.open-initiative-lab_vswitch_name_prefix,
    format(var.number_format, count.index + 1),
  )
  tags = {
    App_Service : "open-initiative-lab",
    Env : "Prod",
    Technical_Owner : "DevOps",
    Business_Owner : "Product Engineering",
    Version : 0.1
  }
}

resource "alicloud_vswitch" "open-initiative-lab_pod_vswitches" {
  count      = length(var.open-initiative-lab_pod_vswitch_cidrs)
  vpc_id     = alicloud_vpc.open-initiative-lab-prod.id
  cidr_block = element(var.open-initiative-lab_pod_vswitch_cidrs, count.index)
  zone_id    = element(var.availability_zones, count.index)
  vswitch_name = format(
    "%s-pod-%s",
    var.open-initiative-lab_vswitch_name_prefix,
    format(var.number_format, count.index + 1),
  )
  tags = {
    App_Service : "open-initiative-lab",
    Env : "Prod",
    Technical_Owner : "DevOps",
    Business_Owner : "Product Engineering",
    Version : 0.1
  }
}

# SOURCE NAT
resource "alicloud_nat_gateway" "open-initiative-lab_snat" {
  vpc_id           = alicloud_vpc.open-initiative-lab-prod.id
  payment_type     = "PayAsYouGo"
  vswitch_id       = alicloud_vswitch.open-initiative-lab_node_vswitches[0].id
  nat_type         = "Enhanced"
  nat_gateway_name = var.open-initiative-lab_nat_name_prefix
  tags = {
    App_Service : "open-initiative-lab",
    Env : "Prod",
    Technical_Owner : "DevOps",
    Business_Owner : "Product Engineering",
    Version : 0.1
  }
}

resource "alicloud_eip" "snat_eip" {
  address_name         = "SNAT_EIP"
  count                = var.new_nat_gateway == true ? 1 : 0
  internet_charge_type = "PayByTraffic"
  bandwidth            = 200
  tags = {
    App_Service : "open-initiative-lab",
    Env : "Prod",
    Technical_Owner : "DevOps",
    Business_Owner : "Product Engineering",
    Version : 0.1
  }
}

resource "alicloud_eip_association" "open-initiative-lab_nat_eip_associate" {
  count         = var.new_nat_gateway == true ? 1 : 0
  allocation_id = alicloud_eip.snat_eip[0].id
  instance_id   = alicloud_nat_gateway.open-initiative-lab_snat.id
}

resource "alicloud_snat_entry" "open-initiative-lab_snat_entry" {
  count             = var.new_nat_gateway == false ? 0 : sum([length(var.open-initiative-lab_node_vswitch_cidrs), length(var.open-initiative-lab_pod_vswitch_cidrs)])
  snat_table_id     = alicloud_nat_gateway.open-initiative-lab_snat.snat_table_ids
  source_vswitch_id = split(",", join(",", concat(alicloud_vswitch.open-initiative-lab_node_vswitches.*.id, alicloud_vswitch.open-initiative-lab_pod_vswitches.*.id)))[count.index % length(split(",", join(",", concat(alicloud_vswitch.open-initiative-lab_node_vswitches.*.id, alicloud_vswitch.open-initiative-lab_pod_vswitches.*.id))))]
  snat_ip           = alicloud_eip.snat_eip[0].ip_address
  depends_on        = [alicloud_eip_association.open-initiative-lab_nat_eip_associate]
}

