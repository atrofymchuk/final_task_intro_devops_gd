
output "app_ip_address" {
  description = "IP address of the app"
  value       = google_compute_instance.instance_app.network_interface.0.access_config.0.nat_ip
}

resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tmpl",
    {
      ip_app       = google_compute_instance.instance_app.network_interface.0.access_config.0.nat_ip,
      name         = google_compute_instance.instance_app.name,
      user_name    = var.ssh_user
      key_app      = local_file.private_key.filename
    }
  )
  filename = "../ansible/inventory_dev"
}
