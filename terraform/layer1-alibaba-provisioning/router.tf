resource "alicloud_route_table" "open-initiative-lab" {
  vpc_id           = alicloud_vpc.open-initiative-lab-prod.id
  route_table_name = "open-initiative-lab"
  associate_type   = "VSwitch"
  tags = {
    App_Service : "open-initiative-lab",
    Env : "Prod",
    Technical_Owner : "DevOps",
    Business_Owner : "Product Engineering",
    Version : 0.1
  }
}

resource "alicloud_route_table_attachment" "ack" {
  count          = sum([length(var.open-initiative-lab_node_vswitch_cidrs), length(var.open-initiative-lab_pod_vswitch_cidrs)])
  vswitch_id     = split(",", join(",", concat(alicloud_vswitch.open-initiative-lab_node_vswitches.*.id, alicloud_vswitch.open-initiative-lab_pod_vswitches.*.id)))[count.index % length(split(",", join(",", concat(alicloud_vswitch.open-initiative-lab_node_vswitches.*.id, alicloud_vswitch.open-initiative-lab_pod_vswitches.*.id))))]
  route_table_id = alicloud_route_table.open-initiative-lab.id
}

resource "alicloud_route_entry" "open-initiative-lab_ack_route_entry" {
  route_table_id        = alicloud_route_table.open-initiative-lab.id
  destination_cidrblock = "0.0.0.0/0"
  nexthop_type          = "NatGateway"
  nexthop_id            = alicloud_nat_gateway.open-initiative-lab_snat.id
}