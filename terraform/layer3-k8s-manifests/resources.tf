resource "local_file" "kubeconf" {
  content  = data.terraform_remote_state.alibaba_infrastructure_state.outputs.ack_auth.kube_config
  filename = "${path.module}/configurations/kubeconfig"
}