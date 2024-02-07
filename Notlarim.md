```bash

terraform {                  
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.35.0"

    }
  }
}     

```

# Bu blok olmadan da bu dosya calisirdi.

# Mesela main.tf dosyasina bir adet resource ekleyip apply komutunu calistirdigimizda eger bizim calistigimiz makine de o resource'u olusturma yetkisi yoksa olusturmaz. Role'kismindan bunu da eklememiz lazim. 


# Terraform apply girince teraform.tfstate ve terraform.tfstate.backup dosyasi olustu.

- terraform.tfstate er en fil som inneholder tilstanden til infrastrukturen som administreres av Terraform. 
Den inneholder informasjon om ressurser som er opprettet og konfigurert av Terraform, inkludert identifikatorer, 
egenskaper og tilkoblinger mellom ressursene.

- terraform.tfstate.backup er en sikkerhetskopi av terraform.tfstate-filen. Denne backup-filen inneholder en kopi av tilstanden til infrastrukturen som administreres av Terraform på et tidspunkt før siste endringer ble utført.



# Terraform init komutunu girince .terraform klasoru ile .terraform.lock.hcl dosyasi olustu.
# .terraform.lock.hcl dosyasi icerigi:

- .terraform.lock.hcl-filen er en fil som inneholder låsingsinformasjon for Terraform-modulavhengigheter. Den brukes til å sikre at Terraform-prosjektet ditt bruker samme versjoner av modulene hver gang det kjøres, og for å forhindre uventede endringer i avhengighetsstrukturen.



> terraform init
# Prepare your working directory for other commands

> terraform plan
# Show changes required by the current configuration

> terraform apply -auto-approve   
# Skip interactive approval of plan before applying.

> terraform validate
# Check whether the configuration is valid

> terraform get
# Install or upgrade remote Terraform modules

> terraform state list
# Brukes til å liste opp alle ressursene som er sporet av Terraform i den gjeldende tilstanden.

> terraform state show aws.instance_example
# brukes til å vise detaljert informasjon om en spesifikk ressurs som er sporet av Terraform i den gjeldende tilstanden.

$ terraform import aws_security_group.tf-sg sg-01b92e29e828a2177
$ terraform import "aws_instance.tf-instances[0]" i-090291cc33c16504c
$ terraform import "aws_instance.tf-instances[1]" i-092fe70d1cef163c1



## Part 1 - Terraform Data Sources

- `Data sources` allow data to be fetched or computed for use elsewhere in Terraform configuration.

- Go to the `AWS console and create an image` from your EC2. Select your instance and from actions click image and templates and then give a name for ami `my-ami` and click create. 

# It will take some time. go to the next steps.

- Go to the `main.tf` file make the changes in order.

```go
provider "aws" {
  region  = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.58.0"
    }
  }
}

locals {
  mytag = "clarusway-local-name"
}

data "aws_ami" "tf_ami" {
  most_recent      = true
  owners           = ["self"]

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

variable "ec2_type" {
  default = "t2.micro"
}

resource "aws_instance" "tf-ec2" {
  ami           = data.aws_ami.tf_ami.id
  instance_type = var.ec2_type
  key_name      = "aduncan"
  tags = {
    Name = "${local.mytag}-this is from my-ami"
  }
}
```

## Part 2 - Terraform Remote State (Remote backend)

- A `backend` in Terraform determines how tfstate file is loaded/stored and how an operation such as apply is executed. This abstraction enables non-local file state storage, remote execution, etc. By default, Terraform uses the "local" backend, which is the normal behavior of Terraform you're used to.

- Go to the AWS console and attach ``DynamoDBFullAccess`` policy to the existing role.

![state-locking](state-locking.png) 

- Se gjerne backend.tf filen for å se coden

- We have created a S3 bucket and a Dynamodb table. Now associate S3 bucket with the Dynamodb table.

- Go to the `main.tf` file make the changes.


## Part 3 - Terraform Provisioners

- Provisioners can be used to model specific actions on the local machine or on a remote machine in order to prepare servers or other infrastructure objects for service.

- The `local-exec` provisioner invokes a local executable after a resource is created. This invokes a process on the machine running Terraform, not on the resource.

- The `remote-exec` provisioner invokes a script on a remote resource after it is created. This can be used to run a configuration management tool, bootstrap into a cluster, etc. To invoke a local process, see the local-exec provisioner instead. The remote-exec provisioner supports both ssh and winrm type connections.

- The `file` provisioner is used to copy files or directories from the machine executing Terraform to the newly created resource. The file provisioner supports both ssh and winrm type connections.

- Most provisioners require access to the remote resource via SSH or WinRM, and expect a nested connection block with details about how to connect. Connection blocks don't take a block label, and can be nested within either a resource or a provisioner.

- The `self` object represents the provisioner's parent resource, and has all of that resource's attributes. For example, use `self.public_ip` to reference an aws_instance's public_ip attribute.

- Take your `pem file` to your local instance's home folder for using `remote-exec` provisioner.

