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
  value = "${module.oouve-ecs-service.ecs-service-role-uid}"
}
