#-------------------------45_launch_configuration/main.tf-------------------------------
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

#-------------variable section--------------------
variable "launch-config-name" {}
variable "ecs-instance-profile-id" {}
variable "vpc-id" {}
variable "alb-subnet-tagname" {}
variable "ecs-image-id" {}
variable "ecs-instance-type" {}
#-------------data section------------------------

data "aws_subnet_ids" "oouve-subnet-id" {
  vpc_id = "${var.vpc-id}"

  filter {
    name   = "tag:Name"
    values = ["${var.alb-subnet-tagname}*"]
  }
}
#-------------control section---------------------

# create launch configuration for the ECS instances
resource "aws_launch_configuration" "oouve-launch-config" {
  name                 = "${var.launch-config-name}-launch-config"
  image_id             = "${var.ecs-image-id}"
  instance_type        = "${var.ecs-instance-type}"
  iam_instance_profile = "${var.ecs-instance-profile-id}"

  root_block_device {
    volume_type           = "standard"
    volume_size           = 100
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

  #  security_groups             = ["${aws_security_group.test_public_sg.id}"]
  #  associate_public_ip_address = "true"
  #  key_name                    = "${var.ecs_key_pair_name}"
  user_data = <<EOF
#!/bin/bash
echo ECS_CLUSTER=${var.launch-config-name} >> /etc/ecs/ecs.config
EOF
}

# Deploy autoscaling group
resource "aws_autoscaling_group" "oouve-autoscaling-group" {
  name                   = "oouve-autoscaling-group"
  max_size               = "4"
  min_size               = "1"
  desired_capacity       = "2"
  vpc_zone_identifier    = "${data.aws_subnet_ids.oouve-subnet-id.ids}"
  launch_configuration   = "${aws_launch_configuration.oouve-launch-config.name}"
  health_check_type      = "ELB"
}

#-------------output section----------------------
output "autoscaling-group" {
  value = "${aws_autoscaling_group.oouve-autoscaling-group.name}"
}
output "launch-configuration" {
  value = "${aws_launch_configuration.oouve-launch-config.name}"
}
