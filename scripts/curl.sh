#!/bin/bash
CIAN="\e[36m"
RESET="\e[0m"

# Verificar argumentos
if [ $# -lt 2 ]; then
    echo "Uso: $0 <PUERTO> <METODO> [ENDPOINT] [DATA_FILE]"
    echo "Ejemplos:"
    echo "  $0 4001 POST /new register-data.json  # Para crear usuario"
    echo "  $0 4001 POST / login-data.json        # Para login"
    echo "  $0 4001 GET /renew                    # Para renovar token (sin datos)"
    exit 1
fi

# Set the API endpoint URL
PORT=$1
METHOD=$2
ENDPOINT=${3:-"/"}  # Tercer parámetro opcional, default "/"
DATA_FILE_NAME=${4:-"data.json"}  # Cuarto parámetro opcional, default "data.json"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATA_FILE="$SCRIPT_DIR/$DATA_FILE_NAME"
API_URL="http://localhost:$PORT/api/auth$ENDPOINT"

RESPONSE_FILE="$SCRIPT_DIR/response.json"

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
# printf "${CIAN}  %-10s %-60s ${RESET}\n" "RESPUESTA GUARDADA EN $RESPONSE_FILE"
# echo "Contenido del archivo de respuesta:"
# if [ -f "$RESPONSE_FILE" ] && [ -s "$RESPONSE_FILE" ]; then
#     cat "$RESPONSE_FILE"
# else
#     echo "⚠️  El archivo de respuesta está vacío o no existe"
#     echo "Esto puede indicar que:"
#     echo "  - El servidor no está corriendo en el puerto $PORT"
#     echo "  - El endpoint $API_URL no existe"
#     echo "  - Hay un problema de conectividad"
# fi
