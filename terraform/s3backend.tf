terraform {
  backend "s3" {
    bucket       = "cornel-terraform-bucket"
    key          = "terraform/state2"
    region       = "eu-west-1"
    use_lockfile = true
  }
}