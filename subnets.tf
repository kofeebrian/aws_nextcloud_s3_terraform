resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.nextcloud_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availability_zone

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private_subnet_db" {
  vpc_id            = aws_vpc.nextcloud_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.availability_zone

  tags = {
    Name = "private-subnet-db"
  }
}

resource "aws_subnet" "private_subnet_nat" {
  vpc_id            = aws_vpc.nextcloud_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = var.availability_zone

  tags = {
    Name = "private-subnet-nat"
  }
}
