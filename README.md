# Springboot Acaex Template

El objetivo de este proyecto es tener un un punto de partida común en los desarrollos del Servicio.

Tener configuraciones
- Api First (uso de fichero OpenApi y generación automática de Controllers y DTOs)
- Pom - Dependencias comunes y configuraciones probadas
- Versionado - uso de comando de node en conjuncion con Conventional Commits
- CI/CD - Fichero de gitlab preparado (necesita configuración en repo)
- Carpeta - Estructura básica
- Vs Code - Integración con el IDE (tareas, snippets)
- Logs - Configuración de Logback para escribir a fichero


## ¿Qué incluye?

1. [Template](/docs/01.template.md) Se baja un template de [Spring Initializr](https://start.spring.io/) con configuracion y dependencias especificas.
2. [Resources Folder](/docs/02.resources.md) Archivos para la carpeta `resources` del proyecto (properties mínimo, archivo de logback, fichero openapi)
3. [AppController](/docs/03.appcontroller.md) Creacion de un Controller con unos endpoints básicos
4. [pom.xml](/docs/04.pomxml.md) Modificaciones en el pom.xml (perfiles, repositorio, propiedades, dependencias, trabajo de build)
5. [.versionrc](/docs/05.versionrc.md) Configuracion de archivo para gestionar versionado de la aplicación en conjunción de comando de [commit-and-tag-version](https://github.com/absolute-version/commit-and-tag-version) con [Conventional Commits](https://github.com/absolute-version/commit-and-tag-version) (Especificación para nombre de commits y ayudar a que los mensajes tengan una estructura normalizada)
6. [.env.properties.example](/docs/06.envpropertiesexample.md) Un archivo de ejemplo para generar archivo de entorno
7. [.gitlab-ci.yml](/docs/07.gitlabciyml.md) Archivo para Gitlab y despliegue continuo, necesita configuracion en el propio repositorio para añadir Variables
8. [.gitignore](/docs/08.gitignore.md) Uso de gitignore para evitar meter archivos no deseados en el repositorio
9. [Estructura de Carpetas](/docs/09.folderstructure.md) Montamos la estructura de carpeta (models, repositories, controller, services)
10. [Carpeta VS Code](/docs/10.vscodefolder.md) Dejamos algunas configuraciones y tareas para el entorno de Vs Code (snippets, tareas, botones, recomendaciones de extensiones)
11. [Scripts](/docs/11.scripts.md) Scripts para cmd, ayuda en el setup.
12. [Ejemplo con Datos](/docs/12.example.md) Posibilidad de añadir Código y Datos Funcionales