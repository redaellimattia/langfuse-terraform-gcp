# Azure AD SSO Secret
resource "kubernetes_secret" "langfuse_sso_azure_ad" {
  count = var.auth_azure_ad_enabled ? 1 : 0
  metadata {
    name      = "langfuse-sso-azure-ad"
    namespace = kubernetes_namespace.langfuse.metadata[0].name
  }

  data = {
    AUTH_AZURE_AD_CLIENT_SECRET = var.auth_azure_ad_client_secret
  }

  depends_on = [
    kubernetes_namespace.langfuse
  ]
}
