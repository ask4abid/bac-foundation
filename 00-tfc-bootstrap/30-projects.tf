resource "tfe_workspace" "projects-dev" {
  name                          = "30-projects-dev"
  organization                  = var.tfc_organization
  project_id                    = tfe_project.project.id
  description                   = "Dev Projects"
  tag_names                     = ["projects", "dev"]
  allow_destroy_plan            = true
  global_remote_state           = true
  terraform_version             = "1.3.9"
  structured_run_output_enabled = true
  queue_all_runs                = false
  working_directory             = "30-projects/envs/dev/"
  trigger_prefixes = [
    "30-projects/modules/projects"
  ]
  vcs_repo {
    identifier     = var.github_repo
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}

resource "tfe_workspace_variable_set" "projects-dev" {
  variable_set_id = tfe_variable_set.gcp-org-data.id
  workspace_id    = tfe_workspace.projects-dev.id
}

resource "tfe_workspace_variable_set" "projects-wif-dev" {
  variable_set_id = tfe_variable_set.workload-identity.id
  workspace_id    = tfe_workspace.projects-dev.id
}

resource "tfe_variable" "projects-dev-gcp-service-account-email" {
  workspace_id = tfe_workspace.projects-dev.id
  key          = "TFC_GCP_RUN_SERVICE_ACCOUNT_EMAIL"
  value        = google_service_account.tf-sa["tf-project-creator-dev"].email
  category     = "env"
  description  = "The GCP service account email runs will use to authenticate."
}

resource "tfe_workspace" "projects-stg" {
  name                          = "30-projects-stg"
  organization                  = var.tfc_organization
  project_id                    = tfe_project.project.id
  description                   = "Stg Projects"
  tag_names                     = ["projects", "stg"]
  allow_destroy_plan            = true
  global_remote_state           = true
  terraform_version             = "1.3.9"
  structured_run_output_enabled = true
  queue_all_runs                = false
  working_directory             = "30-projects/envs/stg/"
  trigger_prefixes = [
    "30-projects/modules/projects"
  ]
  vcs_repo {
    identifier     = var.github_repo
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}

resource "tfe_workspace_variable_set" "projects-stg" {
  variable_set_id = tfe_variable_set.gcp-org-data.id
  workspace_id    = tfe_workspace.projects-stg.id
}

resource "tfe_workspace_variable_set" "projects-wif-stg" {
  variable_set_id = tfe_variable_set.workload-identity.id
  workspace_id    = tfe_workspace.projects-stg.id
}

resource "tfe_variable" "projects-stg-gcp-service-account-email" {
  workspace_id = tfe_workspace.projects-stg.id
  key          = "TFC_GCP_RUN_SERVICE_ACCOUNT_EMAIL"
  value        = google_service_account.tf-sa["tf-project-creator-stg"].email
  category     = "env"
  description  = "The GCP service account email runs will use to authenticate."
}

resource "tfe_workspace" "projects-prd" {
  name                          = "30-projects-prd"
  organization                  = var.tfc_organization
  project_id                    = tfe_project.project.id
  description                   = "Prd Projects"
  tag_names                     = ["projects", "prd"]
  allow_destroy_plan            = true
  global_remote_state           = true
  terraform_version             = "1.3.9"
  structured_run_output_enabled = true
  queue_all_runs                = false
  working_directory             = "30-projects/envs/prd/"
  trigger_prefixes = [
    "30-projects/modules/projects"
  ]
  vcs_repo {
    identifier     = var.github_repo
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}

resource "tfe_workspace_variable_set" "projects-prd" {
  variable_set_id = tfe_variable_set.gcp-org-data.id
  workspace_id    = tfe_workspace.projects-prd.id
}

resource "tfe_workspace_variable_set" "projects-wif-prd" {
  variable_set_id = tfe_variable_set.workload-identity.id
  workspace_id    = tfe_workspace.projects-prd.id
}

resource "tfe_variable" "projects-dev-prd-service-account-email" {
  workspace_id = tfe_workspace.projects-prd.id
  key          = "TFC_GCP_RUN_SERVICE_ACCOUNT_EMAIL"
  value        = google_service_account.tf-sa["tf-project-creator-prd"].email
  category     = "env"
  description  = "The GCP service account email runs will use to authenticate."
}
