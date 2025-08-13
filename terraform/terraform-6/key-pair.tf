resource "aws_key_pair" "shrukey" {
  key_name   = "keypair" 
  public_key = file("C:/Users/legod/.ssh/key.pub")  # Replace the path for your public key file
}