output "database_endpoint" {
  description = "The database endpoint accessible from the host machine."
  value       = module.database.database_endpoint
}

output "db_connection_string_template" {
  description = "A template for the DB connection string (secrets omitted)."
  value       = module.database.db_connection_string_template
}