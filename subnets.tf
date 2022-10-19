resource "aws_subnet" "Wk19_private_subnet1" {
  vpc_id            = aws_vpc.wk19_pro.id
  cidr_block        = var.Wk19_private_subnet1
  availability_zone = "us-east-1a"

  tags = {
    Name = "Wk19_private_subnet1"
  }
}

resource "aws_subnet" "Wk19_private_subnet2" {
  vpc_id            = aws_vpc.wk19_pro.id
  cidr_block        = var.Wk19_private_subnet2
  availability_zone = "us-east-1a"


  tags = {
    Name = "Wk19_private_subnet2"
  }
}