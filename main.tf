
resource "random_string" "word" {
  length  = 4
  upper   = true
  lower   = true
  number  = true
  special = false
}

terraform {
	backend "local" {
		path = "./terraform.tfstate"
	}
}

data "terraform_remote_state" "state" {
	backend = "local"
}

locals {
	lword = "Second tag"
}

data "null_data_source" "rword" {
	inputs = {
		rword = "${lookup(data.terraform_remote_state.state.outputs, "rword", local.lword)}"
	}
	has_computed_default = "${local.lword}"
}

module "vm_flock" {
	source = "./modules/vm_flock"

	//module_dependecies = [random_string.word.result]

	servers_list = {
		vm1 = {
			tags = {
				name = "${data.null_data_source.rword.outputs["rword"]}"
			}
			enable = true
		}
		vm2 = {
			tags = {
				name = "${data.null_data_source.rword.outputs["rword"]}"
			}
		}
	}
}
