data "aws_ami" "webservers_ami" {
  
  owners = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
  most_recent = true
}

resource "aws_instance" "webservers" {
  count           = "${length(var.subnets_cidr)}"
  ami             = "${data.aws_ami.webservers_ami.id}"
  instance_type   = "${var.instance_type}"
  security_groups = ["${aws_security_group.webservers.id}"]
  subnet_id       = "${element(aws_subnet.public.*.id, count.index)}"
  user_data       = "${file("install_httpd.sh")}"
  tags = {
    Name        = "HelloWorld"
    HSN         = "Prod WebServer"
    Owner       = "${var.tagOwner}"
    Environment = "Prod"
  }
}

