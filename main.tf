module "rg_name" {
  source             = "github.com/ParisaMousavi/az-naming//rg?ref=2022.10.07"
  prefix             = var.prefix
  name               = var.name
  stage              = var.stage
  location_shortname = var.location_shortname
}

module "resourcegroup" {
  # https://{PAT}@dev.azure.com/{organization}/{project}/_git/{repo-name}
  source   = "github.com/ParisaMousavi/az-resourcegroup?ref=2022.10.07"
  location = var.location
  name     = module.rg_name.result
  tags = {
    CostCenter = "ABC000CBA"
    By         = "parisamoosavinezhad@hotmail.com"
  }
}

module "apim_rg_name" {
  source             = "github.com/ParisaMousavi/az-naming//apim?ref=main"
  prefix             = var.prefix
  name               = var.name
  stage              = var.stage
  location_shortname = var.location_shortname
}

module "apim_m_id_name" {
  source             = "github.com/ParisaMousavi/az-naming//mid?ref=2022.10.07"
  prefix             = var.prefix
  name               = "apim"
  stage              = var.stage
  location_shortname = var.location_shortname
}

module "apim_m_id" {
  # https://{PAT}@dev.azure.com/{organization}/{project}/_git/{repo-name}
  source              = "github.com/ParisaMousavi/az-managed-identity?ref=2022.10.07"
  resource_group_name = module.resourcegroup.name
  location            = module.resourcegroup.location
  name                = module.apim_m_id_name.result
  additional_tags = {
    CostCenter = "ABC000CBA"
    By         = "parisamoosavinezhad@hotmail.com"
  }
}

module "apim" {
  # https://{PAT}@dev.azure.com/{organization}/{project}/_git/{repo-name}
  source               = "github.com/ParisaMousavi/az-api-mgmt-v2?ref=main"
  resource_group_name  = module.resourcegroup.name
  location             = module.resourcegroup.location
  name                 = module.apim_rg_name.result
  publisher_name       = "Parisa Moosavinezhad"
  publisher_email      = "parisamoosavinezhad@hotmail.com"
  sku                  = "Basic"
  capacity             = 1
  virtual_network_type = "None"
  subnet_id            = data.terraform_remote_state.network.outputs.subnets["apim"].id
  additional_tags = {
    CostCenter = "ABC000CBA"
    By         = "parisamoosavinezhad@hotmail.com"
  }
}
