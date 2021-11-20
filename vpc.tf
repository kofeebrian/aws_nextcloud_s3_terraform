resource "aws_vpc" "nextcloud_vpc" {
  enable_dns_hostnames = true
  cidr_block           = "10.0.0.0/16"
  tags = {
    Name = "nextcloud-vpc"
  }
}
