#----------------------------------------------------------
# My task with Terraform and GCP
#
# Use Terraform with GCP - Google Cloud Platform
#
# Made by Andrii Trofymchuk
#
#-----------------------------------------------------------

#------ Store terraform state in cloudstorage ----------------

terraform {
  backend "gcs" {
    bucket      = "atrofymchuk-terraform-states"
    prefix      = "infra-state"
    credentials = "../gcp_key/gcp-task-key.json"
  }
}

#----------- Provider ---------------------------------------

provider "google" {
  credentials = file(var.keyfile)
  project     = var.project_name
  region      = var.region
  zone        = var.zone
}

#---------------- Bastion instance ------------------------------------

resource "google_compute_instance" "vm_instance_bastion" {
  name         = format("%s-bastion", var.name_env)
  machine_type = var.vm_type_bastion
  tags = [format("%s-allow-out-tcp-22", var.name_env),
  format("%s-allow-bastion-tcp-22", var.name_env)]
  metadata = {
    enable-oslogin = "false"
    ssh-keys       = "${var.ssh_user}:${tls_private_key.ssh_bastion.public_key_openssh}"
  }
  boot_disk {
    initialize_params {
      image = var.image_type_bastion
    }
  }
  network_interface {
    network    = format("%s-network", var.name_env)
    subnetwork = format("%s-subnet-public", var.name_env)
    access_config {
      // Ephemeral public IP
    }
  }
  depends_on     = [google_compute_subnetwork.public_subnetwork]
  desired_status = var.status
}

#------------------- Jenkins instance ---------------------------------

resource "google_compute_instance" "vm_instance_jenkins" {
  name         = format("%s-jenkins", var.name_env)
  machine_type = var.vm_type
  tags = [format("%s-allow-inside-tcp-22", var.name_env),
  format("%s-allow-inside-tcp-8080", var.name_env)]
  metadata = {
    enable-oslogin = "false"
    ssh-keys       = "${var.ssh_user}:${tls_private_key.ssh_jenkins.public_key_openssh}"
  }
  boot_disk {
    initialize_params {
      image = var.image_type
      type  = "pd-ssd"
    }
  }
  network_interface {
    network    = format("%s-network", var.name_env)
    subnetwork = format("%s-subnet-private", var.name_env)
    access_config {
    #   // Ephemeral public IP
    }
  }
  depends_on     = [google_compute_subnetwork.private_subnetwork]
  desired_status = var.status
  }

#-------------- Nexus instance --------------------------------------

resource "google_compute_instance" "vm_instance_nexus" {
  name         = format("%s-nexus", var.name_env)
  machine_type = var.vm_type
  tags = [format("%s-allow-inside-tcp-22", var.name_env),
  format("%s-allow-inside-tcp-8081", var.name_env),
  format("%s-allow-inside-tcp-8082", var.name_env)]
  metadata = {
    enable-oslogin = "false"
    ssh-keys       = "${var.ssh_user}:${tls_private_key.ssh_nexus.public_key_openssh}"
  }
  boot_disk {
    initialize_params {
      image = var.image_type
      type  = "pd-ssd"
    }
  }
  network_interface {
    network    = format("%s-network", var.name_env)
    subnetwork = format("%s-subnet-private", var.name_env)
    access_config {
    #// Ephemeral public IP
    }
  }
  depends_on     = [google_compute_subnetwork.private_subnetwork]
  desired_status = var.status
}
