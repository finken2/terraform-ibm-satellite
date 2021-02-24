
#################################################################################################
# IBMCLOUD & AWS -  Authentication , Target Variables.
# The region variable is common across zones used to setup VSI Infrastructure and Satellite host.
#################################################################################################

variable "ibmcloud_api_key" {
  description  = "IBM Cloud API Key"
  type         = string
}

variable "aws_access_key" {
  description  = "AWS access key"
  type         = string
}

variable "aws_secret_key" {
  description  = "AWS secret key"
  type         = string
}

variable "ibm_region" {
  description = "Region of the IBM Cloud account. Currently supported regions for satellite are `us-east` and `eu-gb` region."
  default     = "us-east"

  validation {
    condition     = var.ibm_region == "us-east" || var.ibm_region == "eu-gb"
    error_message = "Sorry, satellite only accepts us-east or eu-gb region."
  }
}

variable "aws_region" {
  description  = "AWS region"
  type         = string
  default      = "us-west-2"
}

variable "resource_group" {
  description = "Name of the resource group on which location has to be created"
  default      = "default"
  validation {
    condition     = var.resource_group != ""
    error_message = "Sorry, please provide value for resource_group variable."
  }
}

##################################################
# IBMCLOUD Satellite Location Variables
##################################################

variable "location_name" {
  description = "Location Name"
  default     = "satellite-aws-14"

  validation {
    condition     = var.location_name != "" && length(var.location_name) <= 32
    error_message = "Sorry, please provide value for location_name variable or check the length of name it should be less than 32 chars."
  }
}

variable "location_label" {
  description = "Label to create location"
  default     = "env=prod"
}


##################################################
# AWS EC2 Variables
##################################################
variable "satellite_host_count" {
  description    = "The total number of aws host to create for control plane. satellite_host_count value should always be in multiples of 3, such as 3, 6, 9, or 12 hosts"
  type           = number
  default        = 3
  validation {
    condition     = (var.satellite_host_count % 3) == 0 &&  var.satellite_host_count > 0
    error_message = "Sorry, host_count value should always be in multiples of 3, such as 6, 9, or 12 hosts."
  }
}

variable "addl_host_count" {
  description    = "The total number of additional aws host"
  type           = number
  default        = 3
}

variable "instance_type" {
  description    = "The type of aws instance to start, satellite only accepts `m5d.2xlarge` or `m5d.4xlarge` as instance type."
  type           = string
  default        = "m5d.xlarge"

  validation {
    condition     = var.instance_type == "m5d.xlarge" || var.instance_type == "m5d.2xlarge" || var.instance_type == "m5d.4xlarge"
    error_message = "Sorry, satellite only accepts m5d.2xlarge or m5d.4xlarge as instance type."
  }
}

variable "ssh_public_key" {
  description = "SSH Public Key. Get your ssh key by running `ssh-key-gen` command"
  type        = string
  default     = ""
}


locals {
    resource_prefix = format("%s%s","satellite-",formatdate("YYYYMMDDHHmm", timestamp()))
}