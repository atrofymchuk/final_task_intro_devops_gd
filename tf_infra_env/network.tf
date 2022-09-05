#------------ Networks ---------------------------------------

resource "google_compute_network" "vpc_network" {
  project                 = var.project_name
  name                    = format("%s-network", var.name_env)
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "public_subnetwork" {
  name          = format("%s-subnet-public", var.name_env)
  ip_cidr_range = var.ip_cidr_range_public_subnetwork
  region        = var.region
  network       = google_compute_network.vpc_network.name
}

resource "google_compute_subnetwork" "private_subnetwork" {
  name          = format("%s-subnet-private", var.name_env)
  ip_cidr_range = var.ip_cidr_range_private_subnetwork
  region        = var.region
  network       = google_compute_network.vpc_network.name
}

resource "google_compute_address" "ip_address" {
  name = format("%s-public-ip-lb", var.name_env)
  project       = var.project_name
  address_type  = var.type_of_address
  region        = var.region
}
