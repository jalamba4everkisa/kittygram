resource "yandex_vpc_network" "kittygram-network" {
  name = "kittygram-network"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "kittygram-network"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.kittygram-network.id
  v4_cidr_blocks = ["192.168.1.0/24"]
}

output "external_ip_address_kittygram_vm" {
  value = "${yandex_compute_instance.kittygram-vm.network_interface.0.nat_ip_address}"
}

resource "yandex_vpc_security_group" "kittygram-sg" {
  name        = "kittygram-sg"
  network_id  = yandex_vpc_network.kittygram-network.id

  ingress {
    protocol       = "TCP"
    description    = "Allow http port"
    v4_cidr_blocks = ["192.168.1.0/24"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow ssh port"
    v4_cidr_blocks = ["192.168.1.0/24"]
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all egress trafic"
    v4_cidr_blocks = ["192.168.1.0/24"]
    port = -1
  }
}