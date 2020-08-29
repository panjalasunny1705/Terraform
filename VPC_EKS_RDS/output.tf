output "vpc_id" {
    value = "${module.vpc.vpc_id}"
}

output "subnet_ids" {
    value = "${module.vpc.subnet_ids}"
}

output "db_endpoint " {
    value = "${module.aurora.endpoint}"
}

output "cluster_id" {
  description = "The name/id of the EKS cluster. Will block on cluster creation until the cluster is really ready"
  value       = "${module.eks.cluster_id}"
}

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster."
  value       = "${module.eks.cluster_arn}"
}

output "cluster_certificate_authority_data" {
  description = "Nested attribute containing certificate-authority-data for your cluster. This is the base64 encoded certificate data required to communicate with your cluster."
  value       = "${module.eks.cluster_certificate_authority_data}"
}

output "cluster_endpoint" {
  description = "The endpoint for your EKS Kubernetes API."
  value       = "${module.eks.cluster_endpoint}"
}

output "cluster_version" {
  description = "The Kubernetes server version for the EKS cluster."
  value       = "${module.eks.cluster_version}"
}

output "kubeconfig" {
  description = "kubectl config file contents for this EKS cluster."
  value       = "${module.eks.kubeconfig}"
}
