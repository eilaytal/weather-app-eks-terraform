module "allow_eks_access_iam_policy" {
  source  = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy?ref=39e42e1f847afe5fd1c1c98c64871817e37e33ca"

  name          = "allow-eks-access-admin"
  create_policy = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect": "Allow",
        "Action": "*",
        "Resource": "*"
      }
    ]
  })
}

