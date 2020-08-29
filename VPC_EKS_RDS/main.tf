module "vpc" {
    source              = "./vpc"
    vpc_cidr            = "${var.vpc_cidr}"
    environment         = "${var.environment}"
    group_id            = "${var.group_id}"
    subnet_cidr         = "${var.subnet_cidr}"
    availability_zone   = "${var.availability_zone}"
}



module "aurora" {
    source                          = "./rds"
    identifier_prefix               = "${var.aurora["identifier_prefix"]}"
    engine                          = "${var.aurora["engine"]}"
    engine_version                  = "${var.aurora["engine_version"]}"
    vpc_id                          = "${module.vpc_id}"
    subnets                         = "${module.subnet_ids}"
    allowed_cidr_blocks             = "${var.aurora["allowed_cidr_blocks"]}"
    instance_type                   = "${var.aurora["instance_type"]}"
    apply_immediately               = "${var.aurora["apply_immediately"]}"
    db_parameter_group_name         = "${var.aurora["db_parameter_group_name"]}"
    db_cluster_parameter_group_name = "${var.aurora["db_cluster_parameter_group_name"]}"
    environment                     = "${var.environment}"
    group_id                        = "${var.group_id}"
}


module "eks" {
    source                          = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git"
    cluster_name                    = "${var.cluster_name}"
    cluster_version                 = "${var.cluster_version}"
    subnets                         = "${module.subnet_ids}"
    vpc_id                          = "${module.vpc_id}"
    worker_groups                   = "${var.worker_groups}"
}