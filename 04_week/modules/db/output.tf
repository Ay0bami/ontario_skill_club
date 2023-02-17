
# DB related paramters
output "db_settings" {
  value = tomap({
    "port"     = tostring(aws_db_instance.this.port),
    "hostname" = aws_db_instance.this.address,
    "dbname"   = aws_db_instance.this.db_name,
    "username" = aws_db_instance.this.username,
    "pwd_arn"  = aws_secretsmanager_secret.this.arn
  })
}
