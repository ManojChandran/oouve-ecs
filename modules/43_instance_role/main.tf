#--------------------43_instance_role/main.tf------------------------------
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

data "aws_iam_policy_document" "ecs-instance-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
#-------------control section---------------------

# create IAM role for instance
resource "aws_iam_role" "oouve-ecs-instance-role" {
    name                = "oouve-ecs-instance-role"
    path                = "/"
    assume_role_policy  = "${data.aws_iam_policy_document.ecs-instance-policy.json}"
}

# attach IAM instance role with policy
resource "aws_iam_role_policy_attachment" "ecs-instance-role-attachment" {
    role       = "${aws_iam_role.oouve-ecs-instance-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

# get instance profile
resource "aws_iam_instance_profile" "ecs-instance-profile" {
    name = "ecs-instance-profile"
    path = "/"
    role = "${aws_iam_role.oouve-ecs-instance-role.name}"
    provisioner "local-exec" {
      command = "sleep 10"
    }
}
#-------------output section----------------------
output "ecs-instance-profile-id" {
  value = "${aws_iam_instance_profile.ecs-instance-profile.id}"
}
