# Pulls the specified PostgreSQL image from Docker Hub
resource "docker_image" "postgres" {
  name = "postgres:14-alpine"
}

# Creates a named Docker volume for persistent storage
resource "docker_volume" "postgres_data" {
  name = "realworld-postgres-data"
}

# Creates and runs the PostgreSQL container
resource "docker_container" "postgres_db" {
  image = docker_image.postgres.image_id
  name  = "realworld-db-terraform"

  # Set environment variables for the container using our input variables
  env = [
    "POSTGRES_DB=${var.db_name}",
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}",
  ]

  # Map the container's port 5432 to a port on the host machine
  ports {
    internal = 5432
    external = var.db_external_port
  }

  # Mount the persistent volume to the correct data directory
  volumes {
    volume_name = docker_volume.postgres_data.name
    container_path = "/var/lib/postgresql/data"
  }

  # Attach the container to our private network
  networks_advanced {
    name = var.network_id
  }

  # Ensure the container is restarted if it stops
  restart = "always"
}