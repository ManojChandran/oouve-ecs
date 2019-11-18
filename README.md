# Elastic Container Service
Amazon Elastic Container Service (Amazon ECS) is a highly scalable, high-performance container orchestration service that supports Docker containers and allows you to easily run and scale containerized applications on AWS. This repository creates aws ECR, ECS using Terraform.

```
terraform --version
Terraform v0.12.2
+ provider.aws v2.35.0
```
## terraform.tfvars
aws-region      = "us-east-1" </br>
repository-name = "oouve-container" </br>
vpc-id = "vpc-003c62ba7753db2c2" </br>
alb-subnet-tagname = "oouve-pvt-subnet" </br>

# Reference
link 1 : https://github.com/linuxacademy/content-terraform
