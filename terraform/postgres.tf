#  Terraform does not create this resource, but instead "adopts" it into management
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default_VPC"
  }
}

# Create a security group that allows inbound connections on port 5432
resource "aws_security_group" "postgres_sg" {
  vpc_id = aws_default_vpc.default.id
  name = "postgres_sg"

  ingress {
    protocol  = "tcp"
    self      = true
    from_port = 5432
    to_port   = 5432
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Postgres_SG"
  }
}

# Setup random password for DB
resource "random_password" "db_password" {
  length  = 16
  special = false
}

# Provision AWS PostgreSQL Database
# The Amazon RDS Free Tier is available to you for 12 months. Each calendar month, the free tier will allow you to use the Amazon RDS resources listed below for free:
# 750 hrs of Amazon RDS in a Single-AZ db.t2.micro Instance.
# 20 GB of General Purpose Storage (SSD).
# 20 GB for automated backup storage and any user-initiated DB Snapshots.
resource "aws_db_instance" "covid19_db" {
  identifier             = "covid19-etl-db"
  allocated_storage      = 10
  max_allocated_storage  = 100
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "12.3"
  instance_class         = "db.t2.micro"
  name                   = var.db_name
  username               = var.db_user
  password               = random_password.db_password.result
  vpc_security_group_ids = [aws_security_group.postgres_sg.id]
  multi_az               = false # Outside of scope of free tier
  publicly_accessible    = true
  skip_final_snapshot    = true
  apply_immediately      = true # If this is false, changes won't take effect until next maintenance window
  enabled_cloudwatch_logs_exports = ["postgresql"]
}
