#------------------------------------------------------------
# Use Terraform with GCP - Google Cloud Platform
#
# Made by Andrii Trofymchuk
#
#-----------------------------------------------------------

#------Store terraform state in cloudstorage----------

terraform {
  backend "gcs" {
    bucket      = "atrofymchuk-terraform-states"
    prefix      = "templ-state"
    credentials = "../gcp_key/gcp-task-key.json"
  }
}

#-------Provider----------------------------------

provider "google" {
  credentials = file(var.keyfile)
  project     = var.project_name
  region      = var.region
  zone        = var.zone
}

#------------------SSH-keys------------------------------
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "local_file" "private_key" {
  content         = tls_private_key.ssh.private_key_openssh
  filename        = "../ssh_keys/atrofymchuk_tmpl"
  file_permission = "0600"
}


#---------------Instance  ----------------------------

resource "google_compute_instance" "instance_app" {
  name         = format("%s-app", var.name_env)
  machine_type = var.vm_type
  tags = [format("%s-allow-out-tcp-ssh", var.name_env),
  format("%s-allow-out-tcp-app", var.name_env)]
  metadata = {
    enable-oslogin = "false"
    ssh-keys       = "${var.ssh_user}:${tls_private_key.ssh.public_key_openssh}"
  }
  boot_disk {
    initialize_params {
      image = var.image_type
    }
  }
  network_interface {
    network    = format("%s-network", var.name_env)
    subnetwork = format("%s-subnet-public", var.name_env)
    access_config {
    }
  }
  depends_on     = [google_compute_subnetwork.public_subnetwork]
}