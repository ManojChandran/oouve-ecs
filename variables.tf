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
