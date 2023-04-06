provider "aws" {
	region = "us-east-1"
}

resource "aws_s3_bucket" "us-east-1mybucket1997" {
	bucket = "us-east-1mybucket1997"
	acl = "private"
	tags = {
		name = "us-east-1mybucket1997"
	}
}

resource "local_file" "file" {
	filename = "test.txt"
	content = "test"
}

resource "aws_s3_object" "upload_file" {
	content = local_file.file.filename
	key = "test.txt"
	bucket = aws_s3_bucket.us-east-1mybucket1997.id
}

data "aws_iam_user" "Naveen"{
	user_name = "Naveen"
}


resource "aws_s3_bucket_policy" "policy" {
	bucket = aws_s3_bucket.us-east-1mybucket1997.id
    policy = jsonencode(
	{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Principal": {
				"AWS": [
					"${data.aws_iam_user.Naveen.arn}"
				]
			},
			"Effect": "Allow",
			"Action": "*",
			"Resource": "arn:aws:s3:::${aws_s3_bucket.us-east-1mybucket1997.id}/*"
		}
	]
})
}