output "VMs_data" {
  value = {
    vm_name1 = yandex_compute_instance.vm-01.name
    fqdn_name1 = yandex_compute_instance.vm-01.fqdn
    external_ip1 = yandex_compute_instance.vm-01.network_interface.0.nat_ip_address

    vm_name2 = yandex_compute_instance.vm-02.name
    fqdn_name2 = yandex_compute_instance.vm-02.fqdn
    external_ip2 = yandex_compute_instance.vm-02.network_interface.0.nat_ip_address

    vm_name3 = yandex_compute_instance.nat-vm-01.name
    fqdn_name3 = yandex_compute_instance.nat-vm-01.fqdn
    external_ip3 = yandex_compute_instance.nat-vm-01.network_interface.0.nat_ip_address
 }
}
