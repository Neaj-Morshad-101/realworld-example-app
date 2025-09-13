output "container_name" {
  value = docker_container.postgres_db.name
}

output "database_endpoint" {
  description = "The database endpoint accessible from the host machine."
  value       = "localhost:${docker_container.postgres_db.ports[0].external}"
}

output "db_connection_string_template" {
  description = "A template for the DB connection string (secrets omitted)."
  value       = "postgres://<USER>:<PASSWORD>@localhost:${docker_container.postgres_db.ports[0].external}/${var.db_name}"
}