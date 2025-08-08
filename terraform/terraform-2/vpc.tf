data "aws_vpc" "main" {
  id = "vpc-0727d4c2cf510e13e"
}

output "vpc_cidr" {
    value = data.aws_vpc.main.cidr_block
  
}