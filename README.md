# Assignment repository for Advanced Cloud
```
Team Members: 
Rolwyn Quadras, NUID - 001554737, quadras.r@northeastern.edu
Manoj Reddy Amireddy, NUID - 002196218, amireddy.m@northeastern.edu
Aishwarya Kamlakar Sawant, NUID - 002191784, sawant.ais@northeastern.edu
```

# Assignment-01  ami-jenkins and ansible
## Packer
Packer init command to install plugins

```packer init jenkins-ami.pkr.hcl```

Packer script validation command

```packer validate jenkins-ami.pkr.hcl```

Packer build command

```packer build -var-file="variables.pkrvars.hcl" jenkins-ami.pkr.hcl``` 

