resource "aws_ssm_parameter" "db_endpoint" {
  name        = "/database/${var.db_name}/endpoint"
  description = "Endpoint to connect to the ${var.db_name} database"
  type        = "String"
  value       = aws_db_instance.covid19_db.address
}

resource "aws_ssm_parameter" "db_user" {
  name        = "/database/${var.db_name}/user"
  description = "Name of the ${var.db_name} database"
  type        = "String"
  value       = var.db_user
}

resource "aws_ssm_parameter" "db_password" {
  name        = "/database/${var.db_name}/password"
  description = "Password to the ${var.db_name} database"
  type        = "SecureString"
  value       = random_password.db_password.result
}

resource "aws_ssm_parameter" "db_name" {
  name        = "/database/${var.db_name}/name"
  description = "Name of the ${var.db_name} database"
  type        = "String"
  value       = var.db_name
}