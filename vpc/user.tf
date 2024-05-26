module "user1_iam_user" {
  source  = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-user?ref=39e42e1f847afe5fd1c1c98c64871817e37e33ca"

  name                          = "eks-manager"
  create_iam_access_key         = false
  create_iam_user_login_profile = false

  force_destroy = true
}
