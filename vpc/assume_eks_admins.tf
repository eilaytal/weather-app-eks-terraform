module "allow_assume_eks_admins_iam_policy" {
  source  = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy?ref=39e42e1f847afe5fd1c1c98c64871817e37e33ca"

  name          = "allow-assume-eks-admin-iam-role"
  create_policy = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Resource = module.eks_admins_iam_role.iam_role_arn
      },
    ]
  })
}
