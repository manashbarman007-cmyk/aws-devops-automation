# Step 1 : Create IAM ROLE
resource "aws_iam_role" "admin_role" {
  name = "ec2-bastion-admin-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Step 2 : Attach the AdministratorAccess policy to the role
resource "aws_iam_role_policy_attachment" "admin_attach" {
  role       = aws_iam_role.admin_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Step 3 : Create an instance profile and associate it with the IAM role (we attach this to the ec2 instance)
resource "aws_iam_instance_profile" "admin_profile" {
  name = "ec2-bastion-admin-profile"
  role = aws_iam_role.admin_role.name
}