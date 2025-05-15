resource "yandex_compute_disk" "boot-disk" {
  name     = "boot-disk"
  type     = "network-hdd"
  zone     = "ru-central1-a"
  size     = "20"
  image_id = "fd866d9q7rcg6h4udadk"
}

resource "yandex_compute_instance" "kittygram-vm" {
  name = "kittygram-vm"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk.id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = {
    serial-port-enable = "1"
    user-data = templatefile("${path.module}/init/vm-install.yml", 
    {
      SSH_KEY = var.PUB_SSH_KEY
    })
  }
}