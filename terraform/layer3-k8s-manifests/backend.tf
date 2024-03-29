terraform {
  backend "oss" {
    bucket = "tf-ack"
    prefix = "tf-automation/"
    key    = "k8s_manifests.tfstate"
  }
}
