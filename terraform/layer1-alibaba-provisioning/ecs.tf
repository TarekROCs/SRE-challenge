resource "alicloud_instance" "bastion" {
  instance_name              = "bastion"
  resource_group_id          = alicloud_resource_manager_resource_group.detection.id
  security_groups            = [alicloud_security_group.bastion.id]
  vswitch_id                 = alicloud_vswitch.open-initiative-lab_node_vswitches.0.id
  internet_charge_type       = "PayByTraffic"
  internet_max_bandwidth_out = 100

  instance_charge_type = "PostPaid"
  image_id             = "ubuntu_22_04_x64_20G_alibase_20230907.vhd"
  instance_type        = "ecs.c6.large"


  system_disk_category          = "cloud_essd"
  system_disk_performance_level = "PL0"
  system_disk_size              = 20

  key_name = alicloud_ecs_key_pair.publickey.key_pair_name

  connection {
    type        = "ssh"
    user        = var.ssh_username
    private_key = file(var.ssh_private_key_path)
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install tinyproxy -y",
    ]
  }

  provisioner "file" {
    source      = "./configurations/tinyproxy.conf"
    destination = "/etc/tinyproxy/tmp.conf"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo sed -e 's/fake-username/${var.tinyproxy_username}/g' -e 's/fake-password/${var.tinyproxy_password}/g' /etc/tinyproxy/tmp.conf > /etc/tinyproxy/tinyproxy.conf"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo systemctl restart tinyproxy"
    ]
  }

  tags = {
    App_Service : "JumpHost",
    Env : "Prod",
    Technical_Owner : "DevOps",
    Business_Owner : "Product Engineering",
    Version : 0.1
  }
}