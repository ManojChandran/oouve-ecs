#-------------------------44_ecs_alb/main.tf-------------------------------
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
variable "vpc-id" {}
variable "alb-subnet-tagname" {}

#-------------data section------------------------
data "aws_subnet_ids" "oouve-subnet-id" {
  vpc_id = "${var.vpc-id}"

  filter {
    name = "tag:Name"
    values = ["${var.alb-subnet-tagname}*"]
  }
}
#-------------control section---------------------

# create a aws_alb
resource "aws_alb" "oouve-ecs-alb" {
    name                = "oouve-ecs-alb"
    #security_groups     = ["${aws_security_group.test_public_sg.id}"]
    subnets             = "${data.aws_subnet_ids.oouve-subnet-id.ids}"

    tags = {
      Name = "oouve-ecs-alb"
    }
}

resource "aws_alb_target_group" "ecs-target-group" {
    name                = "ecs-target-group"
    port                = "80"
    protocol            = "HTTP"
    vpc_id              = "${var.vpc-id}"

    health_check {
        healthy_threshold   = "5"
        unhealthy_threshold = "2"
        interval            = "30"
        matcher             = "200"
        path                = "/"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = "5"
    }

    tags = {
      Name = "oouve-ecs-target-group"
    }
}

resource "aws_alb_listener" "oouve-alb-listener" {
    load_balancer_arn = "${aws_alb.oouve-ecs-alb.arn}"
    port              = "80"
    protocol          = "HTTP"

    default_action {
        target_group_arn = "${aws_alb_target_group.ecs-target-group.arn}"
        type             = "forward"
    }
}

#-------------output section----------------------
output "aws-alb-sub-ids" {
  value = "${join(", ", data.aws_subnet_ids.oouve-subnet-id.ids)}"
}
output "aws-alb-dns-name" {
  value = "${aws_alb.oouve-ecs-alb.dns_name}"
}
