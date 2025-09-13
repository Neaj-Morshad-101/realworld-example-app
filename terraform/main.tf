# Configure the required providers
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

# This simulates our "compute" environment by creating an isolated network
module "compute" {
  source = "./modules/compute"
}

# This provisions our PostgreSQL database inside the compute environment
module "database" {
  source = "./modules/database"

  # Pass variables down to the database module
  db_name          = var.db_name
  db_user          = var.db_user
  db_password      = var.db_password
  db_external_port = var.db_external_port

  # Connect the database to the network created by the compute module
  network_id = module.compute.network_id
}