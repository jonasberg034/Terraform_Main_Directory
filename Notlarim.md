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




