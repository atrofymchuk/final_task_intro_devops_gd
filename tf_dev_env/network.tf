#------------Networks-------------------------------

resource "google_compute_network" "vpc_network" {
  project                 = var.project_name
  name                    = format("%s-network", var.name_env)
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "public_subnetwork" {
  name          = format("%s-subnet-public", var.name_env)
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
  network       = google_compute_network.vpc_network.name
}

