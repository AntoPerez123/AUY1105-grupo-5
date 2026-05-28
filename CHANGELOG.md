
# Changelog

Todos los cambios importantes de este repositorio serán documentados en este archivo.

El formato está basado en Semantic Versioning: MAJOR.MINOR.PATCH.

## [2.0.0] - 28-05-2026

### Changed
- Adaptación del repositorio principal para la Evaluación Parcial N°2.
- Separación del código de infraestructura en módulos reutilizables.
- Reemplazo del código directo de redes por llamada al módulo `terraform-aws-vpc-AUY1105-antonia`.
- Reemplazo del código directo de EC2 por llamada al módulo `terraform-aws-ec2-AUY1105-antonia`.
- Actualización del provider AWS a versión compatible con los módulos.
- Actualización de documentación del repositorio principal.

### Added
- Integración del módulo de redes en versión `v1.0.0`.
- Integración del módulo de cómputo EC2 en versión `v1.0.0`.
- Validación exitosa con `terraform init` y `terraform validate`.

## [1.0.0] - 28-05-2026

### Added
- Creación inicial del repositorio de infraestructura de la Evaluación Parcial N°1.
- Incorporación de archivos Terraform base.
- Incorporación de políticas de validación.
- Incorporación de workflow de GitHub Actions.