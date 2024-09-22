#!/bin/bash

# Obtenemos el nombre de la función Lambda como argumento
HANDLER_NAME="$1"

if [ -z "$HANDLER_NAME" ]; then
    echo "Error: Debes proporcionar el nombre de la función Lambda como argumento."
    exit 1
fi

# Crear directorio temporal
mkdir temp

# Copiar archivo principal
cp handlers/"${HANDLER_NAME}".py temp/

# Instalar dependencias en el directorio temporal
pip install -r requirements.txt -t temp

cp -r handlers/internal temp/

cd ./temp

# Crear zip del contenido del directorio temporal
zip -r ../${HANDLER_NAME}.zip *

cd ..

rm -rf temp