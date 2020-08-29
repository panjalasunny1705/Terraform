variable "vpc_cidr" {
    default = "10.0.0.0/16"
}
variable "environment" {
    default = "production"
}
variable "group_id" {
    default = "prod-2"
}
 variable "subnet_cidr" {
     default = ["10.0.1.0/24", "10.0.2.0/24" ]
 }
variable "availability_zone" {
    default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "aurora"{
    default = {
    identifier_prefix               = "test-aurora"
    engine                          = "aurora"
    engine_version                  = "5.6.10a"
    allowed_cidr_blocks             = ["10.0.0.0/16"]
    instance_type                   = "db.r4.large"
    apply_immediately               = true
    db_parameter_group_name         = "default"
    db_cluster_parameter_group_name = "default"
    }
}



variable "cluster_name" {
    default  = "EKS-cluster"
}

variable "cluster_version" {
    default = "1.17"
}

variable "worker_groups"{
   default = [
    {
      instance_type = "m4.large"
      asg_max_size  = 5
    }
  ]
}