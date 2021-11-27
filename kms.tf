resource "aws_kms_key" "week13-kms" {
  description             = "Week_7 KMS Key"
  deletion_window_in_days = 10
}

resource "aws_kms_alias" "week13-kms" {
  name          = "alias/week13-kms"
  target_key_id = aws_kms_key.week13-kms.key_id
}
