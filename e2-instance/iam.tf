resource "aws_iam_group" "Elite-developersADMIN" {
  name = "Elite-developersADMIN"
  path = "/users/"
}
resource "aws_iam_group_policy" "ELITE_developer_policy" {
  name  = "Elite_developer_policy"
  group = aws_iam_group.Elite-developersADMIN.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
resource "aws_iam_user" "elite-useradmin" {
  name = "elite-useradminINFRA"
  path = "/users/"

  tags = {
    tag-key = "useradmin"
  }
}
resource "aws_iam_access_key" "Elite-user-access" {
  user = aws_iam_user.elite-useradmin.name
}
resource "aws_iam_user_policy" "Elite-admin-policy" {
  name = "elite-admin-policy"
  user = aws_iam_user.elite-useradmin.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
resource "aws_iam_user_group_membership" "Elite-members-infra" {
  user = aws_iam_user.elite-useradmin.name

  groups = [aws_iam_group.Elite-developersADMIN.name]
}
# resource "aws_iam_user" "elite-useradmin" {
#   name = "elite-useradmin"
# }
# resource "aws_iam_group" "Elite-developersADMIN" {
#   name = "Elite-developersADMIN"
# }