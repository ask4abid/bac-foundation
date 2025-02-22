resource "tfe_workspace" "shared-services" {
  name                          = "04-shared-services"
  organization                  = var.tfc_organization
  project_id                    = tfe_project.project.id
  description                   = "Common services shared amongst all the environments"
  tag_names                     = ["common", "global", "shared"]
  allow_destroy_plan            = true
  global_remote_state           = true
  terraform_version             = "1.3.9"
  structured_run_output_enabled = true
  queue_all_runs                = false
  working_directory             = "04-shared-services"
  vcs_repo {
    identifier     = var.github_repo
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}

resource "tfe_workspace_variable_set" "shared-services" {
  variable_set_id = tfe_variable_set.gcp-org-data.id
  workspace_id    = tfe_workspace.shared-services.id
}

resource "tfe_workspace_variable_set" "shared-services-wif" {
  variable_set_id = tfe_variable_set.workload-identity.id
  workspace_id    = tfe_workspace.shared-services.id
}

resource "tfe_variable" "shared-services-gcp-service-account-email" {
  workspace_id = tfe_workspace.shared-services.id
  key          = "TFC_GCP_RUN_SERVICE_ACCOUNT_EMAIL"
  value        = google_service_account.tf-sa["tf-project-creator-shared"].email
  category     = "env"
  description  = "The GCP service account email runs will use to authenticate."
}
