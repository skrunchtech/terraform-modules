output "admin_iam_group_arn" {
  description = "Admin Group ARN"
  value       = "${element(concat(aws_iam_group.admin.*.arn, list("")), 0)}"
}

output "admin_iam_group_id" {
  description = "Admin Group ID"
  value       = "${element(concat(aws_iam_group.admin.*.unique_id, list("")), 0)}"
}

output "ro_admin_iam_group_arn" {
  description = "Readonly Admin Group ARN"
  value       = "${element(concat(aws_iam_group.admin_readonly.*.arn, list("")), 0)}"
}

output "ro_admin_iam_unique_id" {
  description = "Readonly Admin Group ID"
  value       = "${element(concat(aws_iam_group.admin_readonly.*.unique_id, list("")), 0)}"
}

output "developer_iam_group_arn" {
  description = "Developer Group ARN"
  value       = "${element(concat(aws_iam_group.developer.*.arn, list("")), 0)}"
}

output "developer_iam_unique_id" {
  description = "Developer Group ID"
  value       = "${element(concat(aws_iam_group.developer.*.unique_id, list("")), 0)}"
}

output "billing_admin_iam_group_arn" {
  description = "billing_admin Group ARN"
  value       = "${element(concat(aws_iam_group.billing_admin.*.arn, list("")), 0)}"
}

output "billing_admin_iam_unique_id" {
  description = "billing_admin Group ID"
  value       = "${element(concat(aws_iam_group.billing_admin.*.unique_id, list("")), 0)}"
}

# output "admin_iam_group_users" {
#   description = "admin Group users"
#   value       = "${element(concat(aws_iam_group_membership.full_admins.*.users, list("")), 0)}"
# }

# output "read_only_admin_iam_group_users" {
#   description = "Readonly admin Group users"
#   value       = "${element(concat(aws_iam_group_membership.read_only_admins.*.users, list("")), 0)}"
# }

# output "developers_iam_group_users" {
#   description = "developers Group users"
#   value       = "${element(concat(aws_iam_group_membership.developers.*.users, list("")), 0)}"
# }

output "billing_admins_iam_group_users" {
  description = "billing_admin Group users"
  value       = "${element(concat(aws_iam_group_membership.billing_admins.*.users, list("")), 0)}"
}

output "force_mfa_policy_arn" {
  description = "Force MFA Policy ARN"
  value = "${element(concat(aws_iam_policy.force_mfa.*.arn, list("")), 0)}"
}

output "admin_iam_group_name" {
  description = "Admin Name"
  value       = "${element(concat(aws_iam_group.admin.*.name, list("")), 0)}"
}

output "read_only_admin_iam_group_name" {
  description = "Read only Admin Name"
  value       = "${element(concat(aws_iam_group.admin.*.name, list("")), 0)}"
}

output "developer_iam_group_name" {
  description = "Developer Admin Name"
  value       = "${element(concat(aws_iam_group.admin.*.name, list("")), 0)}"
}

output "billing_admin_iam_group_name" {
  description = "Billing Admin Name"
  value       = "${element(concat(aws_iam_group.admin.*.name, list("")), 0)}"
}
