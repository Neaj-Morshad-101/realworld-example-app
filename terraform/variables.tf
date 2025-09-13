variable "db_name" {
  description = "The name of the PostgreSQL database."
  type        = string
  default     = "realworld_db"
}

variable "db_user" {
  description = "The username for the PostgreSQL database."
  type        = string
  default     = "myuser"
}

variable "db_password" {
  description = "The password for the PostgreSQL database."
  type        = string
  sensitive   = true # Marks this as sensitive, so it won't be shown in outputs
  default     = "mypassword"
}

variable "db_external_port" {
  description = "The port on the host machine to map to the container's port 5432."
  type        = number
  default     = 5432
}