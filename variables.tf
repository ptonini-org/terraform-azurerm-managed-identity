variable "name" {}

variable "rg" {
  type = object({
    name     = string
    location = string
    id       = string
  })
}

variable "role_assignments" {
  type = map(object({
    role_definition_name = string
    scope                = string
  }))
  default  = {}
  nullable = false
}

variable "federated_credentials" {
  type = map(object({
    display_name = optional(string)
    issuer       = string
    subject      = string
    audience     = optional(set(string), ["api://AzureADTokenExchange"])
  }))
  default  = {}
  nullable = false
}
