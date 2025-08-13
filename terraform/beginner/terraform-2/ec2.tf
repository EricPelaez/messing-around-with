resource "aws_instance" "ubuntu" {
    ami  = "ami-020cba7c55df1f615"
    instance_type = "t2.micro"

    tags = {
        Name = "ec2FromTerraformTest"
    }
}

resource "aws_instance" "proxy" {

    ami = "ami-020cba7c55df1f615"
    instance_type = "t3.small"

    tags = {
        Name = "ProxyFromTerraformTest"
    }
  
}