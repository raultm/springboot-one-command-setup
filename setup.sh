#!/usr/bin/bash

# https://stackoverflow.com/questions/36829997/how-to-import-shell-functions-from-one-file-into-another
source "functions.sh"

APP_NAME=$1

echo $APP_NAME

download_and_unzip_springboot_initializr $APP_NAME
add_acaex_repository $APP_NAME
add_dependencies $APP_NAME
add_plugins $APP_NAME
setup_vscode_folder $APP_NAME


echo "Setup complete!"
