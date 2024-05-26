resource "helm_release" "weatherapp" {
  name       = "weatherapp"  # Adjust the name if needed
  repository = "https://github.com/eilaytal/gitops-manifests"  # Adjust the repository if needed
  chart      = "weatherapp_chart"  # Adjust the chart name if needed
  version    = "1.0.0"  # Adjust the version if needed
  namespace  = "argocd"  # Namespace where the application will be deployed
}
