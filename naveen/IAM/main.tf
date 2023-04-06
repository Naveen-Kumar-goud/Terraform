# 1. Create user
# 2. Create Group
# 3. Add users to group
# 4. Create policy
# 5. Attched policy to the group
# 6. generate access key ID and Secret access
# 7. print access Key ID and Secret access

provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "kumar_user" {
  name = "Kumar"
  tags = {
    name        = "kumar"
    Description = "Creating Kumar user"
  }
}

resource "aws_iam_group" "Developer_group" {
  name = "Developer"
}

resource "aws_iam_user_group_membership" "Add_user_group" {
  user   = aws_iam_user.kumar_user.name
  groups = [aws_iam_group.Developer_group.name]
}

resource "aws_iam_policy" "developer_policy" {
  name   = "developer_policy"
  policy = file("policy.json")
}

resource "aws_iam_group_policy_attachment" "attach_policy_to_group"{
  group = aws_iam_group.Developer_group.name
  policy_arn = aws_iam_policy.developer_policy.arn
}

resource "aws_iam_access_key" "Credentials"{
	user   = aws_iam_user.kumar_user.name
}

output "Key" {
	value = "Key : ${aws_iam_access_key.Credentials.id}"
	sensitive = true
}

output "Secret" {
	value = "Secret : ${aws_iam_access_key.Credentials.secret}"
	sensitive = true
}