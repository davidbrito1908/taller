
# Configuración
OUTPUT_DIR="/home/david/monitoreo"  # Directorio donde se guardarán los resultados
LOG_FILE="$OUTPUT_DIR/recursos_sistema_$(date +'%Y-%m-%d_%H').log"  # Archivo de log con timestamp
GRAPH_FILE="$OUTPUT_DIR/recursos_sistema_$(date +'%Y-%m-%d_%H-%M-%S').png"  # Archivo de gráfico

# Llamar al script de Python para generar el gráfico
python3 /media/sf_compartido/taller/graficar.py "$LOG_FILE" "$GRAPH_FILE"
