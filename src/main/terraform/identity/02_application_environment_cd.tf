resource "azuread_application" "environment_cd" {
  display_name = "${local.app_name}-cd"
}

resource "azuread_service_principal" "environment_cd" {
  #application_id = azuread_application.environment_cd.application_id
  client_id = azuread_application.environment_cd.client_id
}

resource "azuread_application_federated_identity_credential" "environment_cd" {
  #application_object_id = azuread_application.environment_cd.object_id
  application_id = azuread_application.environment_cd.id
  display_name          = "github-federated"
  description           = "github-federated"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:${var.github.org}/${var.github.repository}:environment:${var.env}-cd"
}

resource "azurerm_role_assignment" "environment_cd_subscription" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.environment_cd.object_id
}

#resource "azurerm_role_assignment" "environment_cd_subscription_blob_owner" {
#  scope                = data.azurerm_subscription.current.id
#  role_definition_name = "Storage Blob Data Owner"
#  principal_id         = azuread_service_principal.environment_cd.object_id
#}

output "azure_environment_cd" {
  value = {
    app_name       = "${local.app_name}-cd"
    #client_id      = azuread_service_principal.environment_cd.application_id
    client_id      = azuread_service_principal.environment_cd.client_id
    #application_id = azuread_service_principal.environment_cd.application_id
    object_id      = azuread_service_principal.environment_cd.object_id
  }
}
