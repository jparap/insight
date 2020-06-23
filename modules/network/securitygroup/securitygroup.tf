variable vpc_id {}
variable cidr {}
variable env {}
variable id {}

#security group for SSH
resource "aws_security_group" "cloudops-http" {
  name        = "cloudops-http"
  description = "Allows incoming traffic for http"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = "${var.vpc_id}"

  tags = {
    Name = "${var.env}-${var.id}-kp-worker"
  }

  lifecycle {
    ignore_changes = ["ingress", "egress"]
  }
}

#output_variable
output "cloudops-http" {
  value = "${aws_security_group.cloudops-http.id}"
}
