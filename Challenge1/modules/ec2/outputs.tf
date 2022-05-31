output "fingerprint" {
  value = aws_key_pair.ec2-keypair.fingerprint
}
output "name" {
  value = aws_key_pair.ec2-keypair.key_name
}
output "id" {
  value = aws_key_pair.ec2-keypair.id
}
