resource "local_file" "pet" {
    filename = "/root/pets.txt"
    file_permission = "0700"
    content = "I love ${data.local_file.dogs.content}"
    lifecycle {
      create_before_destroy = true
    }
}

resource "local_sensitive_file" "name" {
    filename = "djjd"
    content = "djdj"
}

data "local_file" "dogs" {
  filename = "/root/dogs.txt"
}