data "aws_security_group" "default" {
  vpc_id = local.vpc.id
  filter {
    name   = "group-name"
    values = ["default"]
  }
}
