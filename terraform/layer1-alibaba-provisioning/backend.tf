terraform {
  backend "oss" {
    bucket = "tf-ack"
    prefix = "tf-automation/"
    key    = "alibaba_infrastructure.tfstate"
  }
}
