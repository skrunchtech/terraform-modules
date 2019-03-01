variable "allow_password_change_without_mfa" {
  description = "Allow changing the user password without MFA"
  default = "true"
}

variable "create_admin" {
  description = "Create admin group? "
  default = "true"
}

variable "create_ro_admin" {
  description = "Create read-only admin group?"
  default = "true"
}

variable "create_dev" {
  description = "Create developer Group?"
  default = "true"
}

variable "create_billing_admin" {
  description = "Create Billing Admin Group?"
  default = "false"
}

variable "full_admin_users" {
  description = "Name of the IAM users to add to Admin group"
  default = []
}

variable "ro_admin_users" {
  description = "Name of the IAM users to add to Read Only Admin group"
  default = []
}

variable "dev_users" {
  description = "Name of the IAM users to add to Developer group"
  default = []
}

variable "billing_admin_users" {
  description = "Name of the IAM users to add to Billing Admin group"
  default = []
}

variable "create_force_mfa_policy" {
  description = "Create policy that forces MFA usage"
  default = "true"
}

variable "force_mfa_admin" {
  description = "Attach Force MFA policy to Admin group users? "
  default = "true"
}

variable "force_mfa_ro_admin" {
  description = "Attach Force MFA policy to RO Admin group users? "
  default = "true"
}

variable "force_mfa_dev" {
  description = "Attach Force MFA policy to Developer group users? "
  default = "true"
}
variable "force_mfa_billing_admin" {
  description = "Attach Force MFA policy to Billing Admin group users? "
  default = "true"
}