output "kittygram_ip" {
  value = "${yandex_compute_instance.kittygram-vm.network_interface.0.nat_ip_address}"
}