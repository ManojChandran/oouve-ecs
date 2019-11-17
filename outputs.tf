#----root/outputs.tf-----

output "Registry-id" {
  value = "${module.oouve-ecr.registry-id}"
}

output "Repository-url" {
  value = "${module.oouve-ecr.repository-url}"
}

output "Cluster-id" {
  value = "${module.oouve-cluster.cluster-id}"
}

output "ECS-service-role-uid" {
  value = "${module.oouve-ecs-service-role.ecs-service-role-uid}"
}

output "ALB-sub-ids" {
  value = "${module.oouve-alb.aws-alb-sub-ids}"
}
output "ALB-dns-name" {
  value = "${module.oouve-alb.aws-alb-dns-name}"
}
