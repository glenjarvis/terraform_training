###########
## Groups
###########

resource "aws_iam_group" "admins" {
  name = "Admins"
  path = "/admins/"
}

################################
## Policies attached to Groups
################################

#
# Admin Group
#

resource "aws_iam_group_policy_attachment" "admin-group-aws-admin-attach" {
  group      = "${aws_iam_group.admins.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

##########
## Users
##########

resource "aws_iam_user" "glen_jarvis" {
  name = "glen.jarvis"
  path = "/users/"

  tags = {
    "Type" = "Engineer"
  }
}

###############################
### User Membership to Groups
###############################

resource "aws_iam_group_membership" "admin" {
  name = "tf-admin-group-membership"

  users = [
    "${aws_iam_user.glen_jarvis.name}",
  ]

  group = "${aws_iam_group.admins.name}"
}
