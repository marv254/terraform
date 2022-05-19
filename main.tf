#configure aws provider

provider "aws"{
    
}

variable "cidr_blocks" {
    type = list(object({
        cidr_block= string,
        name = string
    }))
    description = "cidr blocks for vpc and subnets"
   
}

variable avail_zone {

}



resource "aws_vpc" "development-vpc"{
    cidr_block = var.cidr_blocks[0].cidr_block
    tags = {
        Name: var.cidr_blocks[0].name
    }
}

resource "aws_subnet" "dev-subnet-1"{
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = var.cidr_blocks[1].cidr_block
    availability_zone = var.avail_zone
      tags = {
        Name: var.cidr_blocks[1].name
    }
}

data "aws_vpc" "existing_vpc" {
    default = true 

}

output "aws-vpc-id"{
    value = aws_vpc.development-vpc.id
}

output "aws-subnet-id"{
    value = aws_subnet.dev-subnet-1.id
}