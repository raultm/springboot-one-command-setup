# Proceso para nuevo Proyecto de API Acaex

Vamos a usar de ejemplo el nombre de proyecto  XXXXXX

## Descargar zip de https://start.spring.io/

```js
    const options = {
        type: "maven-project",
        language: "java",
        bootVersion: "3.3.0",
        baseDir: appName,
        groupId: "es.acaex",
        artifactId: appName,
        description: "Acaex Initializr for " + appName,
        packageName: "es.acaex." + appName,
        packaging: "war",
        javaVersion: 17,
        dependencies: "lombok,h2,devtools,oracle,web"
    }
```

## Archivos para la carpeta `src/main/resources`

- application.properties
- logback-spring.xml
- openapi.yml

## Modificicaciones en el archivo `pom.xml`

- Añadimos properties `finalName` y `directory` usados en perfil `dev`
- Añadir perfil `dev` usado para CI/CD en gitlab
- Dependencias (enfocadas en temas swagger)
  - springdoc-openapi-starter-webmvc-ui@2.3.0
  - validation-api@2.0.1
  - jackson-databind-nullable@0.2.6
  - javax.annotation-api@1.3.2
  - servlet-api@2.5
- Plugin para el build (Generacion automatica de controllers/DTOs)

## Archivo `.versionrc` 

Para configuracion de gestor de versiones

## Archivo `.env.properties.example`

Usado en caso de clonación de proyecto para generar el .env.properties

## Archivo `.gitlab-ci.yml`

Para CI/CD de gitlab con opciones de la DGDA

## Archivo `.gitignore`

Añado entrada .env.properties

## Creación de estructura de carpetas 

- controllers
- models
- repositories
- services

## Controller `AppController.java`

Dos rutas

- `/` para dar información sobre entorno y version
- `/openapi.yml` para exponer el fichero OpenApi que tenemos en resources

## Carpeta `.vscode`

- `tasks.json`: Setup enviroment, spring-boot:run, bump_version
- `settings.json`: Configuraciones concretas para tener compartidas en el proyecto
- `extensions.json`: Extensiones recomendadas para trabajar con el proyecto

## Carpeta `scripts`

Comando `setup.bat` para ejecutar acciones al abrir el proyecto

- Si no existe `.env.properties` hace una copia de `.env.properties.example`
- Si no existe el comando `commit-and-tag-version` lo instala globalmente
- Si no hay repositorio
  - Inicia con rama `desarrollo`: `git init --initial-branch=desarrollo`
  - Genera una versión `0.1.0`: Así se guarda todo lo que tenía el initializr y no se mezcla con lo que hagan los desarrolladores