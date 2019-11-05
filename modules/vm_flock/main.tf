
resource "null_resource" "module_dependencies" {
    depends_on = [ var.module_dependecies ]
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "vm_flock" {
    // works
    for_each = { for k,v in var.servers_list: k=>v }
    // will fail
    //for_each = { for k,v in var.servers_list: k=>v if lookup(v, "enable", false) == true }

    //depends_on = [null_resource.module_dependencies]
    
    ami = "${data.aws_ami.ubuntu.id}"
    instance_type = "t2.micro"
    
    tags = merge(
        lookup(var.servers_list[each.key], "tags", {})
    )

}
