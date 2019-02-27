/*
Module variables
*/

variable "username" {
  description = "Username to create"
}

variable "path" {
  description = "Path"
  default = "/"
}

variable "force_destroy" {
  description = "Force Destroy user even if there's a login profile + IAM key?"
  default = "false"
}

variable "permissions_boundary" {
  description = "permissions_boundaries for the user"
  default = ""
}

variable "enabled" {
  description = "Create the IAM user?"
  default = "true"
}

variable "enable_login_profile" {
  description = "Create a login profile for the user?"
  default = "true"
}

variable "pgp_key" {
  description = "Base-64 encoded PGP public key, or a keybase username in the form `keybase:username`. Required to encrypt password."
}

variable "password_length" {
  description = "Minimum password length"
  default = 12
}

variable "password_reset_required" {
  description = "Require Password reset on first login"
  default = "true"
}

variable "create_access_key" {
  description = "Whether to create an IAM access key for user"
  default = "true"
}

variable "key_version" {
  description = "The version of the key" 
  default = 1
}

variable "rotating_key" {
  description = "Set to true while the key is in rotation and version is changing"
  default = "false"
}


variable "upload_ssh_key" {
  description = "Upload an SSH key for the IAM User"
  default = "false"
}

variable "ssh_key_encoding" {
  description = "The public key encoding format to use in the response. SSH -> ssh-rsa format, PEM -> PEM"
  default     = "SSH"
}

variable "ssh_public_key" {
  description = "The SSH public key. The public key must be encoded in ssh-rsa format or PEM format"
  default     = ""
}

variable "groups" {
  description = "List of IAM user groups this user should belong to"
  type        = "list"
  default     = []
}
