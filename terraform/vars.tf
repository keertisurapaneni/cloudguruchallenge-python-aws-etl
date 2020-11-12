variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "db_name" {
  default = "covid19"
}

variable "db_user" {
  default = "postgres"
}