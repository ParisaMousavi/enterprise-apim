variable "location" {
  type    = string
  default = "westeurope"
}

variable "prefix" {
  description = "This can be a team name as well."
  type    = string
  default = "appexc"
}

variable "stage" {
  type    = string
  default = "dev"
}

variable "name" {
  type    = string
  default = "apim"
}

variable "location_shortname" {
  type    = string
  default = "weu"
}