import smtplib
import sys
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

def send_email(to_email, subject, log_file):
    # Configuración del servidor SMTP
    smtp_server = "smtp.gmail.com"  # Cambia esto por tu servidor SMTP
    smtp_port = 587
    smtp_user = "david.brito.pacheco@gmail.com"  # Cambia esto por tu correo
    smtp_password = "kbgz ytya zccu ttjb"  # Cambia esto por tu contraseña

    # Leer el contenido del archivo de log
    with open(log_file, "r") as file:
        log_content = file.read()

    # Crear el mensaje de correo
    msg = MIMEMultipart()
    msg["From"] = smtp_user
    msg["To"] = to_email
    msg["Subject"] = subject

    # Agregar el contenido del log al cuerpo del correo
    msg.attach(MIMEText(log_content, "plain"))

    # Enviar el correo
    try:
        with smtplib.SMTP(smtp_server, smtp_port) as server:
            server.starttls()
            server.login(smtp_user, smtp_password)
            server.send_message(msg)
        print("Correo enviado exitosamente.")
    except Exception as e:
        print(f"Error al enviar el correo: {e}")

if __name__ == "__main__":
    # Leer argumentos desde la línea de comandos
    if len(sys.argv) != 4:
        print("Uso: send_email.py <correo_destino> <asunto> <archivo_log>")
        sys.exit(1)

    to_email = sys.argv[1]
    subject = sys.argv[2]
    log_file = sys.argv[3]

    send_email(to_email, subject, log_file)
