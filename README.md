# AUY1105-grupo-5

Repositorio principal de la **Evaluación Final Transversal de AUY1105 – Infraestructura como Código II**.

## Descripción

Este proyecto consolida el trabajo desarrollado en las evaluaciones parciales 1, 2 y 3. La solución implementa infraestructura en AWS mediante Terraform, utilizando módulos reutilizables, análisis estático, políticas de seguridad como código, versionado semántico y automatización mediante GitHub Actions.

El repositorio principal funciona como orquestador de los módulos de red y cómputo, manteniendo separados los componentes para facilitar su reutilización, mantenimiento e integración en otros entornos.

## Objetivos

- Implementar infraestructura en AWS utilizando Terraform.
- Separar la solución en módulos reutilizables de red y cómputo.
- Validar automáticamente la calidad y seguridad del código.
- Evaluar cambios mediante políticas OPA.
- Utilizar pull requests para revisar y aprobar modificaciones.
- Aplicar versionado semántico a los módulos.
- Documentar operaciones avanzadas de gestión del estado de Terraform.

## Arquitectura implementada

La solución está compuesta por dos módulos principales.

### Módulo de redes

El módulo de redes crea:

- VPC con soporte DNS.
- Subnet pública.
- Internet Gateway.
- Tabla de rutas pública.
- Asociación entre subnet y tabla de rutas.
- Security Group con reglas para HTTP y SSH.
- Restricción de SSH al bloque interno `10.0.0.0/16`.

### Módulo de cómputo

El módulo de cómputo crea:

- Instancia EC2.
- IAM Role para EC2.
- IAM Instance Profile.
- Volumen raíz cifrado.
- Monitoreo configurable.
- Metadata Service v2 obligatorio mediante IMDSv2.

## Interacción entre módulos

El módulo de redes entrega como salidas el identificador de la subnet y el identificador del Security Group.

Estas salidas son utilizadas por el módulo de cómputo:

```hcl
subnet_id          = module.redes.subnet_ids[0]
security_group_ids = [module.redes.security_group_id]
```

De esta manera, la instancia EC2 se despliega dentro de la red creada por Terraform sin utilizar valores fijos para estas dependencias.

## Módulos utilizados

| Módulo | Repositorio | Versión |
|---|---|---|
| Redes | `terraform-aws-vpc-AUY1105-antonia` | `v1.0.0` |
| Cómputo EC2 | `terraform-aws-ec2-AUY1105-antonia` | `v1.0.0` |

Los módulos son llamados mediante una versión específica para evitar cambios inesperados:

```hcl
source = "github.com/AntoPerez123/terraform-aws-vpc-AUY1105-antonia?ref=v1.0.0"
```

```hcl
source = "github.com/AntoPerez123/terraform-aws-ec2-AUY1105-antonia?ref=v1.0.0"
```

## Estructura del repositorio

```text
AUY1105-grupo-5/
├── .github/
│   └── workflows/
│       └── pipeline.yml
├── Infra/
│   ├── provider.tf
│   ├── vpc.tf
│   ├── ec2.tf
│   ├── iam.tf
│   └── .terraform.lock.hcl
├── policies/
│   ├── ec2.rego
│   └── sg.rego
├── README.md
├── CHANGELOG.md
└── .gitignore
```

## Pipeline de calidad y seguridad

El workflow se encuentra en:

```text
.github/workflows/pipeline.yml
```

El pipeline ejecuta las siguientes etapas:

1. Descarga del repositorio.
2. Configuración de Terraform.
3. Verificación de formato con `terraform fmt`.
4. Inicialización con `terraform init`.
5. Validación con `terraform validate`.
6. Análisis estático mediante TFLint.
7. Análisis de seguridad mediante Checkov.
8. Generación de `terraform plan`.
9. Conversión del plan a formato JSON.
10. Evaluación automática mediante políticas OPA.

## Herramientas de análisis estático

### TFLint

TFLint revisa errores, configuraciones incorrectas y desviaciones de buenas prácticas en el código Terraform.

### Checkov

Checkov analiza configuraciones de infraestructura como código para detectar riesgos de seguridad y configuraciones no recomendadas.

### Terraform Validate

`terraform validate` verifica que la sintaxis y la estructura interna de los archivos Terraform sean correctas.

## Políticas de seguridad OPA

Las políticas se encuentran en la carpeta:

```text
policies/
```

### Política de instancia EC2

La política `ec2.rego` permite únicamente instancias de tipo:

```text
t2.micro
```

Si el plan propone otro tipo de instancia, el pipeline es rechazado.

### Política de acceso SSH

La política `sg.rego` rechaza cualquier Security Group que permita acceso SSH desde:

```text
0.0.0.0/0
```

La configuración final restringe SSH al bloque:

```text
10.0.0.0/16
```

## Escenarios de prueba

### Escenario no conforme

Se evaluó una configuración con SSH abierto desde `0.0.0.0/0`.

Resultado:

```text
Incumplimientos EC2: 0
Incumplimientos Security Group: 1
Pipeline rechazado
```

### Escenario conforme

Se restringió SSH a `10.0.0.0/16`.

Resultado:

```text
Incumplimientos EC2: 0
Incumplimientos Security Group: 0
Todas las políticas de seguridad fueron aprobadas
```

## Flujo de revisión mediante pull requests

Los cambios se desarrollan en ramas independientes y luego se integran mediante pull requests.

El flujo aplicado es:

```text
Rama de trabajo
      ↓
Cambios y commits
      ↓
Pull request hacia main
      ↓
Ejecución automática del pipeline
      ↓
Revisión documentada
      ↓
Corrección de hallazgos
      ↓
Aprobación y merge
```

Este proceso permite mantener trazabilidad sobre los errores detectados, las mejoras aplicadas y el resultado de las validaciones.

## Gestión avanzada del estado

Durante la Evaluación Parcial N.º 3 se realizaron operaciones avanzadas de Terraform, entre ellas:

- `terraform state list`
- `terraform state show`
- `terraform import`
- `terraform refresh`
- `terraform taint`
- `terraform untaint`
- `terraform state rm`
- Recuperación de un archivo de estado perdido.
- Recreación controlada de una instancia EC2.
- Validación final con `terraform plan`.

El resultado final fue:

```text
No changes. Your infrastructure matches the configuration.
```

## Requisitos

| Herramienta | Versión o requisito |
|---|---|
| Terraform | `>= 1.5.0` |
| AWS Provider | `~> 5.0` |
| Git | Versión reciente |
| Cuenta AWS | Credenciales activas |
| GitHub | Repositorio y GitHub Actions |

## Uso local

Ingresar a la carpeta de infraestructura:

```powershell
cd Infra
```

Inicializar Terraform:

```powershell
terraform init
```

Formatear los archivos:

```powershell
terraform fmt -recursive
```

Validar la configuración:

```powershell
terraform validate
```

Generar el plan:

```powershell
terraform plan
```

Aplicar la infraestructura de forma controlada:

```powershell
terraform apply
```

Antes de ejecutar `terraform apply`, se debe revisar el plan y confirmar que las credenciales y permisos de AWS estén vigentes.

## Restricciones de AWS Academy

AWS Academy utiliza credenciales temporales y puede restringir ciertas acciones IAM, como `iam:CreateRole`.

Durante las pruebas prácticas fue necesario adaptar temporalmente el módulo de cómputo para continuar trabajando sin crear nuevos roles IAM. Esta limitación corresponde al entorno del laboratorio y no a un error de Terraform.

## Versionado semántico

Los módulos utilizan versionado semántico:

```text
v0.1.0: versión inicial de desarrollo.
v1.0.0: primera versión estable.
```

La referencia a una versión específica permite mantener estabilidad y compatibilidad en el repositorio principal.

## Repositorios relacionados

- Repositorio principal:  
  https://github.com/AntoPerez123/AUY1105-grupo-5

- Módulo de redes:  
  https://github.com/AntoPerez123/terraform-aws-vpc-AUY1105-antonia

- Módulo de cómputo EC2:  
  https://github.com/AntoPerez123/terraform-aws-ec2-AUY1105-antonia

## Autora

**Antonia Pérez**  
AUY1105 – Infraestructura como Código II  
Duoc UC