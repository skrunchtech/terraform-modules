resource "aws_iam_user" "this" {
  count = "${var.enabled ? 1 : 0}"

  name          = "${var.username}"
  path          = "${var.path}"
  force_destroy = "${var.force_destroy}"
  permissions_boundary = "${var.permissions_boundary}"
}

resource "aws_iam_user_login_profile" "this" {
  count = "${var.enabled && var.enable_login_profile ? 1 : 0}"

  user    = "${aws_iam_user.this.name}"
  pgp_key = "${var.pgp_key}"
  password_length         = "${var.password_length}"
  password_reset_required = "${var.password_reset_required}"

}

resource "aws_iam_access_key" "this_key_v1" {
  count   = "${local.enable_key && (var.rotating_key || (var.key_version %2 == 1)) ? 1 : 0}"

  user    = "${aws_iam_user.this.name}"
  pgp_key = "${var.pgp_key}"
}

resource "aws_iam_access_key" "this_key_v2" {
  count   = "${local.enable_key && (var.rotating_key || (var.key_version %2 == 0)) ? 1 : 0}"

  user    = "${aws_iam_user.this.name}"
  pgp_key = "${var.pgp_key}"
}

resource "aws_iam_user_ssh_key" "this_ssh_key" {
  count = "${var.enabled && var.upload_ssh_key ? 1 : 0}"

  username   = "${aws_iam_user.this.name}"
  encoding   = "${var.ssh_key_encoding}"
  public_key = "${var.ssh_public_key}"
}

resource "aws_iam_user_group_membership" "default" {
  count      = "${var.enabled == "true" && length(var.groups) > 0 ? 1 : 0}"
  user       = "${aws_iam_user.this.name}"
  groups     = ["${var.groups}"]
}


locals {
  enable_key = "${var.enabled && var.create_access_key ? 1 : 0}"
}
