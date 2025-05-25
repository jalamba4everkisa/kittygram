resource "yandex_vpc_network" "kittygram-network" {
  name = "kittygram-network"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "kittygram-network"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.kittygram-network.id
  v4_cidr_blocks = ["192.168.1.0/24"]
}

resource "yandex_vpc_security_group" "kittygram-sg" {
  name        = "kittygram-sg"
  network_id  = yandex_vpc_network.kittygram-network.id

  ingress {
    protocol       = "TCP"
    description    = "Allow http port"
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow ssh port"
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all egress trafic"
    v4_cidr_blocks    = ["0.0.0.0/0"]
  }
}
