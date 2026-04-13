terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}


provider "docker" {}

resource "docker_image" "nginx" {

  name         = "nginx:latest"
  keep_locally = false

}

resource "docker_container" "web" {

  image = docker_image.nginx.image_id
  name  = "tutorial"

  ports {

    internal = 80
    external = 8000

  }
  volumes {

    host_path      = "/home/ubuntu/terraform-docker/index.html"
    container_path = "/usr/share/nginx/html/index.html"
  }
}
