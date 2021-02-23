
module "satellite-location" {
  source            = "../../modules/location"

  location_name     = var.location_name
  location_label    = var.location_label
  ibmcloud_api_key  = var.ibmcloud_api_key
  ibm_region        = var.ibm_region
  endpoint          = "cloud.ibm.com"
  resource_group    = var.resource_group
  host_provider     = "aws"
  zone1             = data.aws_availability_zones.available.names[0]
  zone2             = data.aws_availability_zones.available.names[1]
  zone3             = data.aws_availability_zones.available.names[2]
}