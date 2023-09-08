resource "local_file" "pet" {
    filename = "/root/pets.txt"
    file_permission = "0700"
    content = "I love cats"
}

resource "local_sensitive_file" "name" {
    filename = "djjd"
    content = "djdj"
    lifecycle {
      prevent_destroy = true
    }
}

resource "tls_private_key" "private_key" {
  algorithm   = "RSA"
  rsa_bits  = 2048
  ecdsa_curve = "P384"
  lifecycle {
    create_before_destroy = true
  }
}