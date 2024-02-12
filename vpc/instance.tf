resource "scaleway_instance_server" "deploy_drupal_backend1" {
    name  = "${local.team}-srv1"
    type  = "PRO2-XXS"
    image = "debian_bookworm"
    tags = [ "${local.team}", "web", "apache2" ]
    root_volume {
      size_in_gb = 10
    }
    user_data = {
       role       = "web"
       cloud-init = file("${path.module}/install_drupal_backend1")
    }
    enable_ipv6 = false
    private_network {
       pn_id = scaleway_vpc_private_network.myvpc.id
    }
}

# Seconde instance

resource "scaleway_instance_server" "deploy_drupal_backend2" {
    name  = "${local.team}-srv2"
    type  = "PRO2-XXS"
    image = "debian_bookworm"
    tags = [ "${local.team}", "web", "apache2" ]
    root_volume {
      size_in_gb = 10
    }
    user_data = {
       role       = "web"
       cloud-init = file("${path.module}/install_drupal_backend1")
    }
    enable_ipv6 = false
    private_network {
       pn_id = scaleway_vpc_private_network.myvpc.id
    }
}



# Données en sortie

output "srv1_private_ip" {
  value = "${scaleway_instance_server.deploy_drupal_backend1.private_ip}"
}

output "srv2_private_ip" {
  value = "${scaleway_instance_server.deploy_drupal_backend2.private_ip}"
}
