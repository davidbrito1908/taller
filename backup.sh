#!/bin/bash

# filepath: /path/to/backup.sh

# Configuración
BACKUP_DIR="/home/david/backup"  # Directorio donde se guardará el backup
SOURCE_DIR="a_respaldar"  # Directorio a respaldar
LOG_FILE="/home/david/backup.log"  # Archivo de log
EMAIL="david.brito.pacheco@gmail.com"  # Correo electrónico para enviar el resultado
PYTHON_SCRIPT="/home/david/send_backup.py"  # Ruta al script de Python para enviar correos
BACKUP_DIR2="/media/sf_compartido/taller/backup"  # Directorio de backup en la máquina virtual
# Fecha actual
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

# Nombre del archivo de backup
BACKUP_FILE="$BACKUP_DIR/backup_$DATE.tar.gz"
BACKUP_FILE2="$BACKUP_DIR2/backup_$DATE.tar.gz"

# Crear el directorio de backup si no existe
mkdir -p "$BACKUP_DIR"
mkdir -p "$BACKUP_DIR2"

# Realizar el backup
echo "Iniciando backup: $DATE" > "$LOG_FILE"
if tar -czf "$BACKUP_FILE" "$SOURCE_DIR" >> "$LOG_FILE" 2>&1; then
    echo "Backup completado exitosamente: $BACKUP_FILE" >> "$LOG_FILE"
    STATUS="Backup completado exitosamente."
else
    echo "Error durante el backup." >> "$LOG_FILE"
    STATUS="Error durante el backup."
fi
# Realizar el backup para el repositorio
echo "Iniciando backup: $DATE" > "$LOG_FILE"
if tar -czf "$BACKUP_FILE2" "$SOURCE_DIR" >> "$LOG_FILE" 2>&1; then
    echo "Backup completado exitosamente: $BACKUP_FILE2" >> "$LOG_FILE"
    STATUS="Backup completado exitosamente."
else
    echo "Error durante el backup." >> "$LOG_FILE"
    STATUS="Error durante el backup."
fi

# Llamar al script de Python para enviar el correo
python3 "$PYTHON_SCRIPT" "$EMAIL" "$STATUS" "$LOG_FILE"

cd /media/sf_compartido/taller
git fetch
git pull
git add .
git commit -m "Commit automatico en monitoreo"
git push origin master
echo "Rama subida a GitHub completado con éxito!"
