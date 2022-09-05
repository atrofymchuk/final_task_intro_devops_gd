#------------------Firewall-rules-------------------------

resource "google_compute_firewall" "instance_ssh" {
  name    = format("%s-allow-outside-tcp-22", var.name_env)
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports    = var.port_ssh
  }
  source_ranges = var.source_range_determined
  target_tags   = [format("%s-allow-out-tcp-22", var.name_env)]
}

resource "google_compute_firewall" "instance_http" {
  name    = format("%s-allow-inside-tcp-8080", var.name_env)
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports    = var.port_app
  }
  source_ranges = var.source_range_all
  target_tags   = [format("%s-allow-inside-tcp-8080", var.name_env)]
}