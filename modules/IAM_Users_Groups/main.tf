# Create the STUDENT-GROUP
resource "aws_iam_group" "dev_group" {
  name = "DEV_TEAM"
}

resource "aws_iam_group" "devops_group" {
  name = "DEVOPS_TEAM"
}

# Create IAM Users
resource "aws_iam_user" "users" {
  for_each = var.tags.teams == devops ? toset(var.devops_user)  : toset(var.dev_user)
  #for_each = toset(var.dev_user)
  name = each.key
}

# Add each user to the STUDENT-GROUP
resource "aws_iam_group_membership" "group_membership" {
  name = "student-group-membership"

  group = aws_iam_group.dev_group.name

  users = [for user in aws_iam_user.users : user.name]
}

resource "aws_iam_group_membership" "group_membership2" {
  name = "student-group-membership2"

  group = aws_iam_group.devops_group.name

  users = [for user in aws_iam_user.users : user.name]
}

# Attach the AdministratorAccess policy to the group
resource "aws_iam_group_policy_attachment" "admin_policy" {
  group      = aws_iam_group.devops_group.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "ec2_policy" {
  group      = aws_iam_group.dev_group.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}