resource "local_file" "mypet" {
    filename = "/root/pet.txt"
    content = "Where is mypet?"
}

resource "random_pet" "randompet" {
    prefix = "Mr"
    separator = "-"
    length = 1
}

resource "tls_private_key" "name" {
  algorithm = "RSA"
  rsa_bits = "68"
}