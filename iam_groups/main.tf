/* IAM GROUPS */
resource "aws_iam_group" "admin" {
  count = "${var.create_admin ? 1 : 0}"

  name = "admin"
  path = "/"
}
resource "aws_iam_group" "admin_readonly" {
  count = "${var.create_ro_admin ? 1 : 0}"

  name = "admin_read_only"
  path = "/"
}
resource "aws_iam_group" "developer" {
  count = "${var.create_dev ? 1 : 0}"

  name = "developer_group"
  path = "/"
}
resource "aws_iam_group" "billing_admin" {
  count = "${var.create_billing_admin ? 1 : 0 }"

  name = "billing_admin_group"
  path = "/"
}
/* GROUP Membership */
resource "aws_iam_group_membership" "full_admins" {
  count = "${var.create_admin ? 1 : 0}"

  name = "admin_team"
  users = ["${var.full_admin_users}"]
  group = "${aws_iam_group.admin.name}"
}
resource "aws_iam_group_membership" "read_only_admins" {
  count = "${var.create_ro_admin ? 1 : 0}"

  name  = "read_only_admin_team"
  users = ["${var.ro_admin_users}"]
  group = "${aws_iam_group.admin_readonly.name}"
}
resource "aws_iam_group_membership" "developers" {
  count = "${var.create_dev ? 1 : 0}"

  name  = "developers"
  users = ["${var.dev_users}"]
  group = "${aws_iam_group.developer.name}"
}
resource "aws_iam_group_membership" "billing_admins" {
  count = "${var.create_billing_admin ? 1 : 0 }"

  name  = "billing_admin_group"
  users = ["${var.billing_admin_users}"]
  group = "${aws_iam_group.billing_admin.name}"
}
/* IAM GROUPS AWS POLICY ATTACHMENTS */
resource "aws_iam_group_policy_attachment" "admin_policy" {
  count = "${var.create_admin ? 1 : 0}"

  group      = "${aws_iam_group.admin.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
resource "aws_iam_group_policy_attachment" "admin_read_only_policy" {
  count = "${var.create_ro_admin ? 1 : 0}"

  group      = "${aws_iam_group.admin_readonly.name}"
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
resource "aws_iam_group_policy_attachment" "billing_admin_policy" {
  count = "${var.create_billing_admin ? 1 : 0 }"

  group      = "${aws_iam_group.billing_admin.name}"
  policy_arn = "arn:aws:iam::aws:policy/job-function/Billing"
}


resource "aws_iam_policy" "force_mfa" {
  count = "${var.create_force_mfa_policy ? 1 : 0}"

  name = "Force_MFA"
  path = "/"
  policy = "${var.allow_password_change_without_mfa ? data.aws_iam_policy_document.force_mfa_but_allow_sign_in_to_change_password.json : data.aws_iam_policy_document.force_mfa.json }"
}

resource "aws_iam_group_policy_attachment" "assign_force_mfa_policy_to_admin" {
  count = "${var.create_force_mfa_policy && var.create_admin && var.force_mfa_admin ? 1 : 0}"

  group      = "${aws_iam_group.admin.name}"
  policy_arn = "${aws_iam_policy.force_mfa.arn}"
}

resource "aws_iam_group_policy_attachment" "assign_force_mfa_policy_to_ro_admin" {
  count = "${var.create_force_mfa_policy && var.create_ro_admin && var.force_mfa_ro_admin ? 1 : 0}"

  group      = "${aws_iam_group.admin_readonly.name}"
  policy_arn = "${aws_iam_policy.force_mfa.arn}"
}

resource "aws_iam_group_policy_attachment" "assign_force_mfa_policy_to_dev" {
  count = "${var.create_force_mfa_policy && var.create_dev && var.force_mfa_dev ? 1 : 0}"
  
  group      = "${aws_iam_group.developer.name}"
  policy_arn = "${aws_iam_policy.force_mfa.arn}"
}

resource "aws_iam_group_policy_attachment" "assign_force_mfa_policy_to_billing_admin" {
  count = "${var.create_force_mfa_policy && var.create_billing_admin && var.force_mfa_billing_admin ? 1 : 0}"
  
  group      = "${aws_iam_group.billing_admin.name}"
  policy_arn = "${aws_iam_policy.force_mfa.arn}"
}