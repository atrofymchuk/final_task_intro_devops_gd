#---------- SSH keys ---------------------------------------

resource "tls_private_key" "ssh_bastion" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "local_file" "private_key_bastion" {
  content         = tls_private_key.ssh_bastion.private_key_openssh
  filename        = "../ssh_keys/atrofymchuk_bastion"
  file_permission = "0600"
}

resource "tls_private_key" "ssh_jenkins" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "local_file" "private_key_jenkins" {
  content         = tls_private_key.ssh_jenkins.private_key_openssh
  filename        = "../ssh_keys/atrofymchuk_jenkins"
  file_permission = "0600"
}

resource "tls_private_key" "ssh_nexus" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "local_file" "private_key_nexus" {
  content         = tls_private_key.ssh_nexus.private_key_openssh
  filename        = "../ssh_keys/atrofymchuk_nexus"
  file_permission = "0600"
}