data "terraform_remote_state" "alibaba_infrastructure_state" {
  backend = "oss"
  config = {
    bucket = "tf-ack"
    prefix = "tf-automation/"
    key    = "alibaba_infrastructure.tfstate"
  }
}

