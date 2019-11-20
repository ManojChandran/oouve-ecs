variable "aws-region" {
  description = "stores aws region data"
}

variable "repository-name" {
  description = "stores ECR repository name "
}
variable "cluster-name" {
  description = "stores ECS cluster name "
  default     = ""
}

variable "vpc-id" {
  description = "stores vpc id"
}

variable "alb-subnet-tagname" {
  description = "stores subnet tag name to filter"
}

variable "launch-config-name" {
  description = "stores lunach configuration name"
  default     = ""
}

variable "ecs-instance-profile-id" {
  description = "stores ECS instance profile id"
  default     = ""
}
