#--------------------42_ecs_service/main.tf--------------------------------
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

#-------------data section------------------------

# get ecs iam service policy
data "aws_iam_policy_document" "ecs-service-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}
#-------------control section---------------------

# create iam role
resource "aws_iam_role" "ecs-service-role" {
  name                  = "ecs-service-role"
  path                  = "/"
  force_detach_policies = "true"
  assume_role_policy    = "${data.aws_iam_policy_document.ecs-service-policy.json}"
}

# Attach iam policy
resource "aws_iam_role_policy_attachment" "ecs-service-role-attachment" {
    role       = "${aws_iam_role.ecs-service-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}
#-------------output section----------------------

output "ecs-service-role-uid" {
  value = "${aws_iam_role.ecs-service-role.unique_id}"
}
