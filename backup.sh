#!/bin/bash

# filepath: /path/to/backup.sh

# Configuración
BACKUP_DIR="/home/david/backup"  # Directorio donde se guardará el backup
SOURCE_DIR="a_respaldar"  # Directorio a respaldar
LOG_FILE="/home/david/backup.log"  # Archivo de log
EMAIL="david.brito.pacheco@gmail.com"  # Correo electrónico para enviar el resultado
PYTHON_SCRIPT="/home/david/send_backup.py"  # Ruta al script de Python para enviar correos

# Fecha actual
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

# Nombre del archivo de backup
BACKUP_FILE="$BACKUP_DIR/backup_$DATE.tar.gz"

# Crear el directorio de backup si no existe
mkdir -p "$BACKUP_DIR"

# Realizar el backup
echo "Iniciando backup: $DATE" > "$LOG_FILE"
if tar -czf "$BACKUP_FILE" "$SOURCE_DIR" >> "$LOG_FILE" 2>&1; then
    echo "Backup completado exitosamente: $BACKUP_FILE" >> "$LOG_FILE"
    STATUS="Backup completado exitosamente."
else
    echo "Error durante el backup." >> "$LOG_FILE"
    STATUS="Error durante el backup."
fi

# Llamar al script de Python para enviar el correo
python3 "$PYTHON_SCRIPT" "$EMAIL" "$STATUS" "$LOG_FILE"
