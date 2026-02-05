module "langfuse" {
  source = "../.."

  domain = "langfuse.example.com"

  # Optional use a different name for your installation
  name = "langfuse-sso"

  # Optional: Configure the Subnetwork
  subnetwork_cidr = "10.0.0.0/16"

  # Optional: Configure the Kubernetes cluster
  kubernetes_namespace = "langfuse"

  # Configure Azure AD SSO
  auth_azure_ad = {
    client_id           = "your-client-id"
    client_secret       = "your-client-secret"
    tenant_id           = "your-tenant-id"
    enforcement_domains = "your-domain.com" # Optional: restrict to specific domains
  }

  # Optional: Configure the database instances
  database_instance_tier              = "db-perf-optimized-N-2"
  database_instance_availability_type = "REGIONAL"
  database_instance_edition           = "ENTERPRISE_PLUS"

  # Optional: Configure the cache
  cache_tier           = "STANDARD_HA"
  cache_memory_size_gb = 1

  # Optional: Configure the Langfuse Helm chart version
  langfuse_chart_version = "1.5.14"
}

provider "kubernetes" {
  host                   = module.langfuse.cluster_host
  cluster_ca_certificate = module.langfuse.cluster_ca_certificate
  token                  = module.langfuse.cluster_token
}

provider "helm" {
  kubernetes {
    host                   = module.langfuse.cluster_host
    cluster_ca_certificate = module.langfuse.cluster_ca_certificate
    token                  = module.langfuse.cluster_token
  }
}
