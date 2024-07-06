variable "region" {
  default = "us-east-1"
}

variable "instace_count" {
  default = 2
}

variable "instance_type" {
  type= list(string)
  default = ["t2.medium"]
}

variable "ami_id" {
  description = "amazon machine image"
  default     = "ami-0a0e5d9c7acc336f1"
}