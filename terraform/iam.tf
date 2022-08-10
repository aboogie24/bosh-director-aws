# Create IAM account
# 

resource "aws_iam_user" "bbl" {
  name = "bbl_user"
  path = "/system/"

  tags = { 
    Automation = "Terraform"
  }

}

resource "aws_iam_access_key" "bbl" {
    user = aws_iam_user.bbl.name 
}

resource "aws_iam_user_policy" "bbl" {
    name = "bbl_policy"
    user = aws_iam_user.bbl.name

    policy = jsonencode({
    
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:*",
                    "cloudformation:*",
                    "elasticloadbalancing:*",
                    "iam:*",
                    "route53:*",
                    "logs:*",
                    "kms:*"
                ],
                "Resource": [
                    "*"
                ]
            }
        ]

    })
}

output "secret" {
    value = aws_iam_access_key.bbl.secret
    sensitive = false 
}



