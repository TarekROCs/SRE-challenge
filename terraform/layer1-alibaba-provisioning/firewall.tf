resource "alicloud_security_group" "bastion" {
  name              = "bastion"
  resource_group_id = alicloud_resource_manager_resource_group.open-initiative-lab.id
  vpc_id            = alicloud_vpc.open-initiative-lab-prod.id
  tags = {
    App_Service : "JumpHost",
    Env : "Prod",
    Technical_Owner : "DevOps",
    Business_Owner : "Product Engineering",
    Version : 0.1
  }
}

resource "alicloud_security_group_rule" "ssh_ingress" {
  type              = "ingress"
  ip_protocol       = "all"
  cidr_ip           = "0.0.0.0/0"
  priority          = 1
  policy            = "accept"
  security_group_id = alicloud_security_group.bastion.id
}

resource "alicloud_security_group" "open-initiative-lab-management-cluster" {
  name              = "open-initiative-lab-management-cluster"
  resource_group_id = alicloud_resource_manager_resource_group.open-initiative-lab.id
  vpc_id            = alicloud_vpc.open-initiative-lab-prod.id
  tags = {
    App_Service : "open-initiative-lab Kube Management",
    Env : "Prod",
    Technical_Owner : "DevOps",
    Business_Owner : "Product Engineering",
    Version : 0.1
  }
}