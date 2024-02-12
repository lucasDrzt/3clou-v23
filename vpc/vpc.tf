resource scaleway_vpc_private_network "myvpc" {
}

resource scaleway_vpc_public_gateway_ip "pgw_ip" {
}

resource scaleway_vpc_public_gateway "pgw" {
  type = "VPC-GW-S"
  bastion_enabled = true
  ip_id = scaleway_vpc_public_gateway_ip.pgw_ip.id
}

resource scaleway_vpc_public_gateway_dhcp "dhcp" {
  subnet = "192.168.42.0/24"
  dns_local_name = scaleway_vpc_private_network.myvpc.name
  pool_low = "192.168.42.100"
  pool_high  = "192.168.42.200"
}

resource scaleway_vpc_public_gateway_dhcp_reservation frontsrv1 {
    gateway_network_id = scaleway_vpc_gateway_network.mygw.id
    #mac_address = scaleway_instance_server.web1.private_network.1.mac_address
    #mac_address = scaleway_instance_private_nic.nic1.mac_address
    mac_address = scaleway_instance_server.deploy_drupal_backend1.private_network[0].mac_address

    ip_address = "192.168.42.101"
}

resource scaleway_vpc_public_gateway_dhcp_reservation frontsrv2 {
    gateway_network_id = scaleway_vpc_gateway_network.mygw.id
    mac_address = scaleway_instance_server.deploy_drupal_backend2.private_network[0].mac_address

    ip_address = "192.168.42.102"
}


resource scaleway_vpc_gateway_network "mygw" {
  gateway_id          = scaleway_vpc_public_gateway.pgw.id
  private_network_id  = scaleway_vpc_private_network.myvpc.id
  dhcp_id             = scaleway_vpc_public_gateway_dhcp.dhcp.id
  enable_dhcp         = true
}

# PAT rules

#resource "scaleway_vpc_public_gateway_pat_rule" "http" {
#  gateway_id = scaleway_vpc_public_gateway.pgw.id
#  #private_ip = scaleway_vpc_public_gateway_dhcp.dhcp.address
#  private_ip = "192.168.42.11"
#  private_port = 80
#  public_port = 80
#  protocol = "tcp"
#  depends_on = [scaleway_vpc_gateway_network.mygw, scaleway_vpc_private_network.myvpc]
#}
#
#resource "scaleway_vpc_public_gateway_pat_rule" "https" {
#  gateway_id = scaleway_vpc_public_gateway.pgw.id
#  #private_ip = scaleway_vpc_public_gateway_dhcp.dhcp.address
#  private_ip = "192.168.42.11" 
#  private_port = 443
#  public_port = 443
#  protocol = "tcp"
#  depends_on = [scaleway_vpc_gateway_network.mygw, scaleway_vpc_private_network.myvpc]
#}

# Output
# scaleway_vpc_public_gateway_ip.pgw_ip.address

output "bastion_ip" {
  value = "${scaleway_vpc_public_gateway_ip.pgw_ip.address}"
}

