### IP for LB IP
resource scaleway_lb_ip lb {
}

### Scaleway Load Balancer
resource scaleway_lb lb {
    ip_id = scaleway_lb_ip.lb.id
    name = "${local.team}"
    type = "LB-S"

    private_network {
        private_network_id = scaleway_vpc_private_network.myvpc.id
	    dhcp_config = true
    }

    depends_on = [scaleway_vpc_public_gateway.pgw]
}

resource "scaleway_lb_frontend" "frontend" {
  lb_id        = scaleway_lb.lb.id
  backend_id   = scaleway_lb_backend.backend.id
  name         = "frontend"
  inbound_port = "80"
}

resource "scaleway_lb_backend" "backend" {
  lb_id            = scaleway_lb.lb.id
  name             = "backend"
  forward_protocol = "http"
  forward_port     = "80"
  server_ips = [ "192.168.42.101", "192.168.42.102" ]
}

output "lb_ip" {
  value = "${scaleway_lb.lb.ip_address}"
}
