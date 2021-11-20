variable "shared_credentials_file" {
  description = "shared credentials file"
  default     = "~/.aws/credentials"
}

variable "region" {
  description = "region to run application nextcloud, db and s3"
  default     = "ap-southeast-1"
}
variable "availability_zone" {
  description = "availability zone in the region"
  default     = "ap-southeast-1a"
}
variable "ami" {
  description = "vm image ami (specific for each regoin)"
  default     = "ami-0d058fe428540cd89"
}
variable "database_name" {
  description = "nextcloud database name"
  default     = "nextcloud"
}
variable "database_user" {
  description = "nextcloud database username"
  default     = "username"
}
variable "database_pass" {
  description = "nextcloud database password"
  default     = "password"
}

variable "data_dir" {
  description = "data folder for nextcloud"
  default     = "/var/www/nextcloud/data"
}

variable "admin_user" {
  description = "nextcloud admin username"
  default     = "admin"
}

variable "admin_pass" {
  description = "nextcloud admin password"
  default     = "admin"
}

# S3 variable
variable "bucket_name" {
  description = "name of the s3 bucket to store the data"
  default     = "safetydolphinwalrus010"
}

variable "key_name" {
  description = "ec2 key name"
  default     = "main-key"
}

variable "public_key_path" {
  description = "path to public key to generate ec2 key pair"
  default     = "~/.ssh/id_rsa.pub"
}
