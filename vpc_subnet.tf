provider "aws" {
  region = "ap-south-1" 
  # Replace with your desired AWS region
}


resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16" 
  # Replace with your desired CIDR block


  tags = {
    Name = "SDM_TfStateTestVPC" 
    # Assign a descriptive name to your VPC
  }
}


resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24" 
  # Replace with your desired subnet CIDR block
  availability_zone       = "ap-south-1a" 
  # Replace with your desired availability zone
  map_public_ip_on_launch = true
}


terraform {
  backend "s3" {
    bucket         = "sdm-terraform-state-bucket-2" 
    # Use the same bucket name from Step 1
    key            = "vpc_subnet/terraform.tfstate" 
    # Specify a unique key for this state file
    region         = "ap-south-1" 
    # Use the same region as the bucket
    encrypt        = true
    dynamodb_table = "SDM-terraform-lock" 
    # Optional: Enables state locking
  }
}



