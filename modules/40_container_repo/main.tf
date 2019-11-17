#-------------------40_container_repo/main.tf-------------------------------
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
variable "repository-name" {}

#-------------control section---------------------
# create ECR for container service
resource "aws_ecr_repository" "oouve-repository" {
  name = "${var.repository-name}"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "oouve-repository"
  }
}

#-------------output section------------------------
output "registry-id" {
  value = "${aws_ecr_repository.oouve-repository.registry_id}"
}
output "repository-url" {
  value = "${aws_ecr_repository.oouve-repository.repository_url}"
}
