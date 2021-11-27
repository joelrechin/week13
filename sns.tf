resource "aws_sns_topic" "week13-sns" {
  name              = "week13-sns"
  kms_master_key_id = "alias/aws/sns"
}

resource "aws_sns_topic_subscription" "week13-sns-mail" {
  topic_arn = aws_sns_topic.week13-sns.arn
  protocol  = "email"
  endpoint  = "joelrechin@gmail.com"
}
