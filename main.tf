
resource "random_string" "word" {
  length  = 4
  upper   = true
  lower   = true
  number  = true
  special = false
}

module "vm_flock" {
	source = "./modules/vm_flock"

	module_dependecies = [random_string.word.result]

	servers_list = {
		vm1 = {
			tags = {
				name = "${random_string.word.result}"
			}
			enable = true
		}
		# vm2 = {
		# 	tags = {
		# 		name = "${random_string.word.result}"
		# 	}
		# }
	}
}
