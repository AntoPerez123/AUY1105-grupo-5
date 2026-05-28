# AUY1105-grupo-5


Repositorio principal de infraestructura Terraform para la Evaluación Parcial N°2 de la asignatura AUY1105 - Infraestructura como Código II.

## Descripción del repositorio

Este repositorio corresponde al proyecto principal utilizado para orquestar la infraestructura en AWS mediante módulos reutilizables de Terraform.

El código original de la Evaluación Parcial N°1 fue adaptado y desacoplado en dos módulos independientes:

- Módulo de redes.
- Módulo de cómputo EC2.

El repositorio principal actúa como controlador central, llamando a los módulos publicados en GitHub mediante versionado semántico.

## Módulos utilizados

| Módulo | Repositorio | Versión |
|---|---|---|
| Redes | `terraform-aws-vpc-AUY1105-antonia` | `v1.0.0` |
| Cómputo EC2 | `terraform-aws-ec2-AUY1105-antonia` | `v1.0.0` |

## Arquitectura implementada

La infraestructura se organiza de la siguiente manera:

1. El módulo de redes crea:
   - VPC.
   - Subnet pública.
   - Internet Gateway.
   - Tabla de rutas pública.
   - Security Group para SSH y HTTP.

2. El módulo de cómputo crea:
   - Instancia EC2.
   - IAM Role.
   - IAM Instance Profile.
   - Volumen raíz cifrado.
   - Configuración IMDSv2 obligatoria.

## Estructura del repositorio

```txt
AUY1105-grupo-5/
├── .github/
│   └── workflows/
│       └── pipeline.yml
├── Infra/
│   ├── provider.tf
│   ├── vpc.tf
│   ├── ec2.tf
│   └── iam.tf
├── policies/
│   ├── ec2.rego
│   └── sg.rego
├── README.md
├── CHANGELOG.md
└── .gitignore

Uso del repositorio

Ingresar a la carpeta de infraestructura:

cd Infra

Inicializar Terraform:

terraform init

Formatear archivos Terraform:

terraform fmt

Validar configuración:

terraform validate

Generar plan de ejecución:

terraform plan

Aplicar infraestructura:

terraform apply
Validación realizada

Se ejecutaron correctamente los siguientes comandos:

terraform fmt
terraform init
terraform validate

Resultado obtenido:

Success! The configuration is valid.
Automatización

El repositorio mantiene el workflow de GitHub Actions ubicado en:

.github/workflows/pipeline.yml

Este flujo se utiliza para mantener las validaciones de código estático y seguridad trabajadas desde la Evaluación Parcial N°1.

Versionado de módulos

Los módulos externos fueron publicados con versionado semántico:

v0.1.0: versión inicial.
v1.0.0: versión estable.
Repositorios relacionados
Módulo redes: https://github.com/AntoPerez123/terraform-aws-vpc-AUY1105-antonia
Módulo cómputo EC2: https://github.com/AntoPerez123/terraform-aws-ec2-AUY1105-antonia
Autora

Antonia Pérez
AUY1105 - Infraestructura como Código II
Duoc UC