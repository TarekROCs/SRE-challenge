terraform {
  backend "oss" {
    bucket = "tf-ack"
    prefix = "tf-automation/"
    key    = "helm_charts.tfstate"
  }
}
