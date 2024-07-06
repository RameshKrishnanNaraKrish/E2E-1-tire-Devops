terraform {
  backend "s3" {
    bucket  = "my-tf-test-bucket-backends3"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
