output "bastion_ip" {
  value = alicloud_instance.bastion.public_ip
}