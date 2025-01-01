resource "azurerm_user_assigned_identity" "this" {
  name                = var.name
  location            = var.rg.location
  resource_group_name = var.rg.name
}

resource "azurerm_federated_identity_credential" "this" {
  for_each            = var.federated_credentials
  parent_id           = azurerm_user_assigned_identity.this.id
  resource_group_name = azurerm_user_assigned_identity.this.resource_group_name
  name                = coalesce(each.value.display_name, each.key)
  audience            = each.value.audience
  issuer              = each.value.issuer
  subject             = each.value.subject
}

resource "azurerm_role_assignment" "this" {
  for_each             = var.role_assignments
  principal_id         = azurerm_user_assigned_identity.this.principal_id
  role_definition_name = each.value.role_definition_name
  scope                = each.value.scope
}