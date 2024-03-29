#------------------------------root/main.tf-------------------------------
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#--------------------------------------------------------------------------

provider "aws" {
  region = "${var.aws-region}"
}

# Deploy ECR
module "oouve-ecr" {
  source          = "./modules/40_container_repo"
  repository-name = "${var.repository-name}"
}

# Deploy ECS cluster
module "oouve-cluster" {
  source       = "./modules/41_cluster"
  cluster-name = "${var.repository-name}"
}

# Deploy ECS Service
module "oouve-ecs-service-role" {
  source = "./modules/42_ecs_service_role"
}

# Deploy Instance role
module "oouve-instance-role" {
  source = "./modules/43_instance_role"
}

# Deploy ECS application load balancer
module "oouve-alb" {
  source             = "./modules/44_ecs_alb"
  vpc-id             = "${var.vpc-id}"
  alb-subnet-tagname = "${var.alb-subnet-tagname}"
}

# Deploy ECS launch configuration
module "oouve-launch-config" {
  source                  = "./modules/45_launch_configuration"
  launch-config-name      = "${var.repository-name}"
  ecs-instance-profile-id = "${module.oouve-instance-role.ecs-instance-profile-id}"
  alb-subnet-tagname      = "${var.alb-subnet-tagname}"
  vpc-id                  = "${var.vpc-id}"
  ecs-image-id            = "${var.ecs-image-id}"
  ecs-instance-type       = "${var.ecs-instance-type}"
}
