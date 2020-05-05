Curso Practico IaaS Tech-U
========

En esta parte practica, vamos a ver dos puntos importantes: 
- Ansible
- Terraform 

Ambas aplicaciones netamente relacionadas con la infraestructura como codigo ( IcA ) 

Antes de empezar, vamos a trabajar con Digital Ocean, para ello, deben crear una cuenta, para ello, pueden usar este [-Link]("https://m.do.co/c/35f14306ae1c")

Tambien puede guiarse de este [-Tutorial]("https://github.com/kdetony/clouds/blob/master/Lab.md")

### OBS.

En Digital Ocean, vamos a crear el droplet mas basico ( centos 7.X 64 bits )

Parte 1 
========= 

## Instalacion de Terraform

Para poder conectarnos a nuestro Droplet, podemos usar Putty, Xshell, bash for linux, cualquier cliente SSH. 

Ya en nuestro Droplet, vamos a realizar estas tareas previas:

```
yum -y install epel-release 
yum -y install update 
yum -y install vim vim-enhanced curl wget unzip git
```

Descargamos terraform: 
```
wget -c https://releases.hashicorp.com/terraform/0.12.23/terraform_0.12.23_linux_amd64.zip
```

Instalamos:
```
unzip terraform_0.12.23_linux_amd64.zip
```

Copiamos el binario para poder ejecutar desde la terminal:
```
mv terraform /usr/local/bin/
``` 

Validamos:
```
terraform
```

Desactivamo Selinux
```
vim /etc/selinux/config

*Cambiamos:  enforcing x disabled
```

Reiniciamos:
```
reboot
```

Bien, ahora vamos a clonar el repositorio: 
```
git clone https://github.com/kdetony/iaas-bbva.git
```

Y ahora, nos ubicamos en el directorio **terraform**

En este directorio, encontraremos 2 archivos, lo que ahoremos ahora es ejecutar los sgts comandos:

```
terraform init 
```

Antes de ejecutar los 2 ultimos comandos, debemos crear nuestro token de seguridad en Digital Ocean: 
```
Manage/API/Generate New Token
```

Ahora si, ejecutemos:

```
terraform plan
terraform apply
```

### OBS.
* nos pedira nuestro token, asi que aqui lo copiamos tanto para plan como apply
* cuando ejecutemos apply, debemos escribir: **yes** para validar el proceso de instalacion

Parte 2
==========

En esta parte, vamos a instalar Ansible, para ello seguiremos los sgts pasos: 

```
yum install python3-pip
```

Ahora, instalamos ansible via pip:
```
pip3 install ansible 

pip3 install --upgrade pip
```

Ahora, vamos a trabajar en la carpeta ansible:
```
mkdir -p /opt/ansible
```

### OBS.
* En el archivo *hosts* debemos ingresar la ip publica del droplet que creamos via terraform.
* Debemos copiar la llave ssh de nuestro servidor ORIGEN, para copiarlo en el servidor creado por terraform **OJO!**
* En el servidor donde tenemos instalado **ansible**: 

> ssh-keygen -t rsa

> ssh-copy-id -i ~/.ssh/id_rsa.pub root@IP_SERVIDOR_NUEVO


* Validar el acceso SSH. (no debe pedir contraseña)

Vamos ahora a instalar docker, para ello ejecutamos el playbook:
```
ansible-playbook docker.yml 
```

Ahora vamos a crear contenedores desde ansible, antes de ello ejecutamos previamente:
```
pip3 install docker-py
```

Y ejecutamos: 
```
ansible-playbook container.yml
```
