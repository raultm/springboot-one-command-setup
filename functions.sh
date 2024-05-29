#!/bin/bash

function title {
    message=$1

    echo ""
    echo "  $message"
    echo " -----------------------------------------------------" 
}

function step {
    message=$1

    echo "   - $message"
}

function download_and_unzip_springboot_initializr {
    APP_NAME=$1
    title "1. Descargar y descomprimir Initializr"
    
    step "Nombre del proyecto: $APP_NAME"
    
    curl -s https://start.spring.io/starter.zip \
        -d type=maven-project \
        -d groupId=es.acaex \
        -d artifactId=$APP_NAME \
        -d name=$APP_NAME \
        -d description="$APP_NAME" \
        -d packageName=es.acaex.$APP_NAME \
        -d dependencies=web,jpa \
        -o $APP_NAME.zip
    step "Zip descargado de start.spring.io"
    
    unzip -qq $APP_NAME.zip -d $APP_NAME
    step "Descomprimido"
    rm $APP_NAME.zip
    step "Eliminado el archivo zip"
}

function add_acaex_repository {

    POM_FILE="$1/pom.xml"
    
    title "2. Añadir Repositorio Maven de gitlab"
    # Si yha se ha añadido no volver a hacerlo
    if grep -q "https://gitlab.acaex.es/api/v4/projects/1068/packages/maven" $POM_FILE; then
        step "Repositorio ya existe"
        exit 0
    fi

    # Verificar si existe la etiqueta <repositories>, si no, añadirla
    if ! grep -q "<repositories>" $POM_FILE; then
        sed -i '/<\/project>/i \
    <repositories>\n\
    </repositories>' $POM_FILE
    step "Etiqueta <repositories> no existía y se ha añadido"
    fi

    # Añadir repositorios al archivo pom.xml
    sed -i '/<repositories>/a \
        <repository>\
            <id>acaex-gitlab-maven</id>\
            <url>https://gitlab.acaex.es/api/v4/projects/1068/packages/maven</url>\
        </repository>' $POM_FILE
    step "Añadido el repositorio"

    # cat $POM_FILE
}

function add_dependencies {
    POM_FILE="$1/pom.xml"

    title "3. Añadir Dependencias"

    sed -i '/<dependencies>/a \
    <dependency>\
        <groupId>org.springframework.boot</groupId>\
        <artifactId>spring-boot-starter-data-jpa</artifactId>\
    </dependency>\
    <dependency>\
        <groupId>org.springframework.boot</groupId>\
        <artifactId>spring-boot-starter-thymeleaf</artifactId>\
    </dependency>\
    <dependency>\
        <groupId>mysql</groupId>\
        <artifactId>mysql-connector-java</artifactId>\
        <scope>runtime</scope>\
    </dependency>' $POM_FILE
    step "Dependencias Añadidas"
}

function add_plugins {
    POM_FILE="$1/pom.xml"

    title "4. Añadir Plugin de OpenApi para generar Controllers y DTOs"
    # Verificar si existe la etiqueta <build>, si no, añadirla
    if ! grep -q "<build>" $POM_FILE; then
        sed -i '/<\/project>/i \
  <build>\n\
    <plugins>\\
    </plugins>\\
  </build>' $POM_FILE
    step "Etiqueta <build> no existía y se ha añadido"
    fi

    # Añadir un plugin al archivo pom.xml
    sed -i "/<plugins>/a \
            <plugin>\\
                <groupId>org.openapitools</groupId>\\
                <artifactId>openapi-generator-maven-plugin</artifactId>\\
                <version>6.3.0</version>\\
                <executions>\\
                    <execution>\\
                        <goals>\\
                            <goal>generate</goal>\\
                        </goals>\\
                        <configuration>\\
                            <inputSpec>\${project.basedir}/src/main/resources/openapi.yml</inputSpec>\\
                            <generatorName>spring</generatorName>\\
                            <apiPackage>es.acaex.$APP_NAME.api</apiPackage>\\
                            <modelPackage>es.acaex.$APP_NAME.dto</modelPackage>\\
                            <supportingFilesToGenerate>\\
                                ApiUtil.java\\
                            </supportingFilesToGenerate>\\
                            <configOptions>\\
                                <delegatePattern>true</delegatePattern>\\
                                <serializableModel>true</serializableModel>\\
                            </configOptions>\\
                        </configuration>\\
                    </execution>\\
                </executions>\\
            </plugin>" $POM_FILE
    step "Configurado el plugin para generacion de de Controllers y DTOs a partir de archivo openapi.yml"
}

function setup_vscode_folder {
    VSCODE_FOLDER="$1/.vscode"
    title "5. Archivos de Configuracion de Entorno para VS Code"
    # Crear la carpeta .vscode y añadir archivos de configuración
    mkdir -p $VSCODE_FOLDER
    step "Carpeta .vscode creada"

    # Añadir configuración a .vscode/launch.json
    cat <<EOT >$VSCODE_FOLDER/launch.json
{
    "version": "0.2.0",
    "configurations": [
        {
            "type": "java",
            "name": "Debug (Launch) - Current File",
            "request": "launch",
            "mainClass": "com.example.demo.DemoApplication"
        }
    ]
}
EOT
    step "launch.json creado"

    # Añadir configuración a .vscode/settings.json
    cat <<EOT >$VSCODE_FOLDER/settings.json
{
    "java.configuration.updateBuildConfiguration": "interactive"
}
EOT
    step "settings.json creado"

    # Añadir configuración a .vscode/extensions.json
    cat <<EOT >$VSCODE_FOLDER/extensions.json
{
    "recommendations": [
        "vscjava.vscode-java-pack",
        "pivotal.vscode-spring-boot"
    ]
}
EOT
    step "extensions.json creado"
}
