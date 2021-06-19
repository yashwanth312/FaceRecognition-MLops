// provider 
provider "aws" {
	region = "ap-south-1"
	profile = "yashterra"
}


resource "aws_instance"  "webpage" {
  ami = "ami-0ad704c126371a549"
  instance_type = "t2.micro"
  key_name = "awskey-mumbai"
  security_groups = [ "http" ]
}

//creating volume
resource "aws_ebs_volume" "example" {
  availability_zone = aws_instance.webpage.availability_zone
  size              = 1
}

//Attaching volume to the instance
resource "aws_volume_attachment" "ebs_att_inst" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.webpage.id
  force_detach = true
}

output "publicip" {
	value = aws_instance.webpage.public_ip
}

resource "local_file" "private_key" {
    content  = aws_instance.webpage.public_ip
    filename = "ip"
}