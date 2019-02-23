# instance to be provisioned 
resource "aws_instance" "application-server" {
  ami = "${var.ami_image_id}"
  instance_type = "t2.micro"
  key_name = "cp-devops"

}
