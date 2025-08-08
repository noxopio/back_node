#!/bin/bash
CIAN="\e[36m"
RESET="\e[0m"

# Verificar argumentos
if [ $# -lt 2 ]; then
    echo "Uso: $0 <PUERTO> <METODO> [ENDPOINT] [DATA_FILE]"
    echo "Ejemplos:"
    echo "  $0 4001 POST new register-data.json   # Para crear usuario (/api/auth/new)"
    echo "  $0 4001 POST / login-data.json        # Para login (/api/auth/)"  
    echo "  $0 4001 GET renew                     # Para renovar token (/api/auth/renew)"
    exit 1
fi

# Set the API endpoint URL
PORT=$1
METHOD=$2
ENDPOINT=${3:-"/"}

if [[ "$ENDPOINT" != /* ]]; then
    ENDPOINT="/$ENDPOINT"
fi

DATA_FILE_NAME=${4:-"data.json"} 
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATA_FILE="$SCRIPT_DIR/$DATA_FILE_NAME"
API_URL="http://localhost:$PORT/api/auth$ENDPOINT"


# Make the API request using curl
 printf "${CIAN}  %-10s %-60s ${RESET}\n" "enviando solicitud $METHOD a $API_URL"
echo "Usando archivo de datos: $DATA_FILE"

# Preparar comando curl
#  -o \"$RESPONSE_FILE\"
CURL_CMD="
curl -X \"$METHOD\" \"$API_URL\"
 -H \"Content-Type: application/json\" 
  -w \"HTTP Status: %{http_code}\\nTime: %{time_total}s\\nSize: %{size_download} bytes\\n\" -v"

# Agregar datos solo si el archivo existe y el método no es GET
if [ "$METHOD" != "GET" ] && [ -f "$DATA_FILE" ]; then
    CURL_CMD="$CURL_CMD -d @\"$DATA_FILE\""
fi

# Ejecutar curl
eval $CURL_CMD

echo ""
