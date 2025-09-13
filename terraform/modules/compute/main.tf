# Creates an isolated Docker network for our services
resource "docker_network" "private_network" {
  name = var.network_name
}

# Output the network ID so other modules can use it
output "network_id" {
  value = docker_network.private_network.id
}