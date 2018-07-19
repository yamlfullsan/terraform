# terraform

**Instalar terraform.

**Crear un directorio llamado terraform (se recomienda en /opt/ . Dentro del directorio estarán los archivos de este git.

**El árbol de directorios detro de el directorio terraform debera verse asi:
# tree /opt/terraform/
.
├── elk
│   ├── elasticsearch
│   │   └── elasticsearch.yml
│   ├── kibana
│   │   └── kibana.yml
│   └── logstash
│       ├── logstash.yml
│       ├── pipeline
│       │   └── pipeline.conf
│       └── pipelines.yml
├── elk.tf


**Modificar archivo elk.tf --> modificar rutas host_path si el directorio terraform no se creo en /opt. 
**Si el directorio si se creo en /opt/terraform no se tendrian que realizar modificaciones. 

#sudo terraform plan
#sudo terraform init
