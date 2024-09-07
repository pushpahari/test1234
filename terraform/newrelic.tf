resource "helm_release" "newrelic_k8s" {
  name       = "newrelic-k8s"
  namespace  = "newrelic"
  repository = "https://helm-charts.newrelic.com"
  chart      = "newrelic-infrastructure"
  version    = "3.0.0" # Make sure this is the latest

  values = [
    <<EOF
kubeStateMetrics:
  enabled: true
prometheus:
  enabled: true
global:
  cluster: "${var.cluster_name}" # Specify your EKS cluster name here
  licenseKey: "${var.new_relic_license_key}" # Provide your New Relic license key
  logLevel: "info"
EOF
  ]

  set {
    name  = "global.licenseKey"
    value = var.new_relic_license_key
  }

  set {
    name  = "global.cluster"
    value = var.cluster_name
  }
}

