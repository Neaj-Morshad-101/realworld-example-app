variable "db_name" { type = string }
variable "db_user" { type = string }
variable "db_password" { type = string; sensitive = true }
variable "db_external_port" { type = number }
variable "network_id" { type = string }