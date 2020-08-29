resource "aws_db_subnet_group" "main" {
  name        = "${var.name}"
  description = "Group of DB subnets"
  subnet_ids  = "${var.subnets}"

    tags {
    Name        = "${var.environment}_${var.group_id}"
    environment = "${var.environment}"
    group_id   = "${var.group_id}"
  }
}

resource "random_id" "server" {
  keepers = {
    id = "${aws_db_subnet_group.main[0].name}"
  }

  byte_length = 8
}


// Create single DB instance
resource "aws_rds_cluster_instance" "cluster_instance_0" {

  identifier                   = "${var.identifier_prefix != "" ? format("%s-node-0", var.identifier_prefix) : format("%s-aurora-node-0", var.environment)
  cluster_identifier           = "${aws_rds_cluster.default[0].id}"
  engine                       = "${var.engine}"
  engine_version               = "${var.engine-version}"
  instance_class               = "${var.instance_type}"
  publicly_accessible          = "${var.publicly_accessible}"
  db_subnet_group_name         = "${aws_db_subnet_group.main[0].name}"
  db_parameter_group_name      = "${var.db_parameter_group_name}"
  preferred_maintenance_window = "${var.preferred_maintenance_window}"
  apply_immediately            = "${var.apply_immediately}"
  auto_minor_version_upgrade   = "${var.auto_minor_version_upgrade}"

    tags {
    Name        = "${var.environment_var.group_id}"
    environment = "${var.environment}"
    group_id   = "${var.group_id}"
  }
}


resource "aws_rds_cluster" "default" {
  cluster_identifier = "${var.identifier_prefix != "" ? format("%s-cluster", var.identifier_prefix) : format("%s-aurora-cluster", var.environment)}"
  availability_zones = "${var.availability_zones}"
  engine             = "${var.engine}"

  engine_version                      = "${var.engine-version}"
  master_username                     = "${var.username}"
  master_password                     = "${var.password}"
  final_snapshot_identifier           = "${var.final_snapshot_identifier-random_id.server[0].hex}"
  skip_final_snapshot                 = "${var.skip_final_snapshot}"
  backup_retention_period             = "${var.backup_retention_period}"
  preferred_backup_window             = "${var.preferred_backup_window}"
  preferred_maintenance_window        = "${var.preferred_maintenance_window}"
  port                                = "${var.port}"
  db_subnet_group_name                = "${aws_db_subnet_group.main[0].name}"
  vpc_security_group_ids              = "${var.security_groups}"
  snapshot_identifier                 = "${var.snapshot_identifier}"
  apply_immediately                   = "${var.apply_immediately}"
  db_cluster_parameter_group_name     = "${var.db_cluster_parameter_group_name}"
  iam_database_authentication_enabled = "${var.iam_database_authentication_enabled}"
  vpc_security_group_ids              = "${aws_security_group.rds.id}"
}

resource "aws_security_group" "rds" {

  name_prefix = "${var.environment}_${var.group_id}"
  vpc_id      = "${var.vpc_id}"


    tags {
    Name        = "${var.environment}_${var.group_id}"
    environment = "${var.environment}"
    group_id   = "${var.group_id}"
  }
}

resource "aws_security_group_rule" "default_ingress" {
  count = "${var.create_security_group ? length(var.allowed_security_groups) : 0}"

  type                     = "ingress"
  from_port                = 3306 
  to_port                  = 3306 
  protocol                 = "tcp"
  cidr_blocks               = "${var.allowed_cidr_blocks}"
}
