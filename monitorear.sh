# Configuración
OUTPUT_DIR="/home/david/monitoreo"  # Directorio donde se guardarán los resultados
LOG_FILE="$OUTPUT_DIR/recursos_sistema_$(date +'%Y-%m-%d_%H').log"  # Archivo de log con timestamp
GRAPH_FILE="$OUTPUT_DIR/recursos_sistema_$(date +'%Y-%m-%d_%H-%M-%S').png"  # Archivo de gráfico


# Crear el directorio de salida si no existe
mkdir -p "$OUTPUT_DIR"

# Obtener el uso de CPU
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

# Obtener el uso de memoria
MEMORY_USAGE=$(free -m | awk 'NR==2{printf "%.2f", $3*100/$2 }')

# Obtener el uso de disco
DISK_USAGE=$(df -h / | awk 'NR==2{print $5}' | sed 's/%//')

# Obtener el uso de red (bytes enviados y recibidos)
NETWORK_USAGE=$(cat /proc/net/dev | grep eth0 | awk '{print "Enviados: "$10" bytes, Recibidos: "$2" bytes"}')

if [ ! -f "$LOG_FILE" ]; then
    echo "Monitoreo del sistema - $(date +'%Y-%m-%d_%H')" > "$LOG_FILE"
fi
# Guardar los resultados en el archivo de log
echo "---------------------------------" >> "$LOG_FILE"
echo "$(date +'%Y-%m-%d_%H-%M-%S')" >> "$LOG_FILE"
echo "Uso de CPU: $CPU_USAGE%" >> "$LOG_FILE"
echo "Uso de Memoria: $MEMORY_USAGE%" >> "$LOG_FILE"
echo "Uso de Disco: $DISK_USAGE%" >> "$LOG_FILE"

# Mostrar mensaje de finalización
echo "Monitoreo completado. Resultados guardados en $LOG_FILE"

