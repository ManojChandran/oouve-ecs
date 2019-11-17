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
