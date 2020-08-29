variable "identifier_prefix" {
  description = "Name given resources"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs to use"
  type        = list
  default     = []
}

variable "allowed_cidr_blocks" {
  description = "A list of CIDR blocks which are allowed to access the database"
  type        = list
  default     = ["0.0.0.0/0"]
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}



variable "instance_type" {
  description = "Instance type to use at master instance. If instance_type_replica is not set it will use the same type for replica instances"
  type        = string
}

variable "publicly_accessible" {
  description = "Whether the DB should have a public IP address"
  type        = bool
  default     = false
}


variable "username" {
  description = "Master DB username"
  type        = string
  default     = "root"
}

variable "password" {
  description = "Master DB password"
  type        = string
  default     = ""
}

variable "final_snapshot_identifier" {
  description = "The prefix name to use when creating a final snapshot on cluster destroy, appends a random 8 digits to name to ensure it's unique too."
  type        = string
  default     = "final"
}

variable "skip_final_snapshot" {
  description = "Should a final snapshot be created on cluster destroy"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "How long to keep backups for (in days)"
  type        = number
  default     = 7
}

variable "preferred_backup_window" {
  description = "When to perform DB backups"
  type        = string
  default     = "02:00-03:00"
}

variable "preferred_maintenance_window" {
  description = "When to perform DB maintenance"
  type        = string
  default     = "sun:05:00-sun:06:00"
}

variable "port" {
  description = "The port on which to accept connections"
  type        = string
  default     = "3306"
}

variable "apply_immediately" {
  description = "Determines whether or not any DB modifications are applied immediately, or during the maintenance window"
  type        = bool
  default     = false
}



variable "auto_minor_version_upgrade" {
  description = "Determines whether minor engine upgrades will be performed automatically in the maintenance window"
  type        = bool
  default     = true
}

variable "db_parameter_group_name" {
  description = "The name of a DB parameter group to use"
  type        = string
  default     = "default"
}

variable "db_cluster_parameter_group_name" {
  description = "The name of a DB Cluster parameter group to use"
  type        = string
  default     = "default"
}



variable "snapshot_identifier" {
  description = "DB snapshot to create this database from"
  type        = string
  default     = ""
}

variable "engine" {
  description = "Aurora database engine type, currently aurora, aurora-mysql or aurora-postgresql"
  type        = string
  default     = "aurora"
}

variable "engine_version" {
  description = "Aurora database engine version."
  type        = string
  default     = "5.6.10a"
}


variable "iam_database_authentication_enabled" {
  description = "Specifies whether IAM Database authentication should be enabled or not. Not all versions and instances are supported. Refer to the AWS documentation to see which versions are supported."
  type        = bool
  default     = false
}

variable "environment" {
    default="production"
}

variable "group_id" {
    default="prod-2"
}