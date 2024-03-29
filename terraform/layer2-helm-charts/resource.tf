resource "alicloud_eip_association" "traefik_eip_associate" {
  allocation_id = data.alicloud_eip_addresses.eip_addresses.addresses.0.id
  instance_id   = data.alicloud_slb_load_balancers.traefik_slbs.balancers.0.id
}