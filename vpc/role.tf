module "eks_admins_iam_role" {
  source  = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-assumable-role?ref=39e42e1f847afe5fd1c1c98c64871817e37e33ca"

  role_name         = "eks-admin"
  create_role       = true
  role_requires_mfa = false

  custom_role_policy_arns = [module.allow_eks_access_iam_policy.arn]

  trusted_role_arns = [
    "arn:aws:iam::${module.vpc.vpc_owner_id}:root"
  ]
}
