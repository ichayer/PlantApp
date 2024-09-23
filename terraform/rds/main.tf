resource "aws_db_instance" "planty_db" {
    identifier        = "planty-db"
    engine            = "postgres"
    engine_version    = "16.3"
    instance_class    = "db.t3.medium"
    username          = "postgres"
    password          = var.db_password 
    allocated_storage = 20
    multi_az          = true

    # Storage settings
    storage_type      = "gp3"
    max_allocated_storage = 20

    # Unnecesary characteristics
    performance_insights_enabled  = false
    monitoring_interval           = 0 
    skip_final_snapshot           = true

    # Security group
    vpc_security_group_ids = [var.security_group_id]

    # Subnets
    db_subnet_group_name = var.subnet_group_name

    tags = {
        Name = "planty-db"
        Environment = "dev/test"
    }
}