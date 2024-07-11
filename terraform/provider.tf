terraform {
  backend "s3" {
    bucket = "state-terraform-core"
    key = "states"
  }
}