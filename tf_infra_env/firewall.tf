#------------- Firewall rules ------------------------------

resource "google_compute_firewall" "bastion" {
  name    = format("%s-allow-outside-tcp-22", var.name_env)
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports    = var.port_ssh
  }
  source_ranges = var.source_range_determined
  target_tags   = ["${var.name_env}-allow-out-tcp-22"]
}

resource "google_compute_firewall" "bastion_private" {
  name    = format("%s-allow-inside-tcp-22", var.name_env)
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports    = var.port_ssh
  }
  source_tags = [format("%s-allow-bastion-tcp-22", var.name_env)]
  target_tags = [format("%s-allow-inside-tcp-22", var.name_env)]
}

resource "google_compute_firewall" "private_web" {
  name    = format("%s-allow-inside-tcp-8080", var.name_env)
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports    = var.port_jenkins
  }
  source_ranges = var.source_range_all
  target_tags   = [format("%s-allow-inside-tcp-8080", var.name_env)]
}

resource "google_compute_firewall" "private_web_1" {
  name    = format("%s-allow-inside-tcp-8081", var.name_env)
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports    = var.port_nexus_1
  }
  source_ranges = var.source_range_all
  target_tags   = [format("%s-allow-inside-tcp-8081", var.name_env)]
}

#resource "google_compute_firewall" "private_web_3" {
#  name    = format("%s-allow-inside-tcp-8082", var.name_env)
#  network = google_compute_network.vpc_network.name
#  allow {
#    protocol = "tcp"
#    ports    = var.port_nexus_2
#  }
#  source_ranges = var.source_range_all
#  target_tags   = [format("%s-allow-inside-tcp-8082", var.name_env)]
#}
