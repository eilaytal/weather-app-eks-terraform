variable aws_region {
  type        = string
  description = "AWS region"
  default     = "il-central-1"
}

variable aws_azs {
  type        = list(string)
  description = "AWS Availability Zones"
  default     = ["il-central-1a", "il-central-1b"]
}

variable image_id {
  type        = string
  description = "AMI ID"
  default     = "ami-0c55b159cbfafe1f0"
}

variable instance_type {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable key_pair_name {
  type        = string
  description = "EC2 key pair name"
  default     = "key-pair"
}

variable subnet_cidr {
  type        = string
  description = "CIDR block for the VPC subnet"
  default     = "10.0.0.0/24"
}

variable vpc_name {
  type        = string
  description = "Name of the VPC"
  default     = "eks-vpc"
}

variable vpc_cidr {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "repo_pat" {
  description = "Personal Access Token for the Git repository"
  type        = string
  sensitive   = true
}
