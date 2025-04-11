import sys
import matplotlib.pyplot as plt
import re
import numpy as np

def parse_log_file(log_file):

    data = {
        "CPU": [],
        "Memory": [],
        "Disk": [],
    }
    file = open(log_file, 'r')
    for line in file:
        if "Uso de CPU" in line:
            dato = line.split(':')[1].strip()
            data["CPU"].append(float(dato.replace('%', '').strip().replace(',', '.')))
        elif "Uso de Memoria" in line:
            dato = line.split(':')[1].strip()
            data["Memory"].append(float(dato.replace('%', '').strip().replace(',', '.')))
        elif "Uso de Disco" in line:
            dato = line.split(':')[1].strip()
            data["Disk"].append(float(dato.replace('%', '').strip().replace(',', '.')))

    return data

def generate_graph(data, output_file):

    values = list(data.values())

    x = np.arange(0,len(values[0]), 1)
    plt.figure(figsize=(10, 6))
    plt.scatter(x, values[0], label='Uso de CPU', color='blue')
    plt.scatter(x, values[1], label='Uso de Memoria', color='green')
    plt.scatter(x, values[2], label='Uso de Disco', color='red')
    plt.plot(x, values[0], label='Uso de CPU', color='blue')
    plt.plot(x, values[1], label='Uso de Memoria', color='green')
    plt.plot(x, values[2], label='Uso de Disco', color='red')
    plt.legend()
    plt.title("Recursos del Sistema")
    plt.ylabel("Porcentaje")
    plt.xlabel("Tiempo (Minuto)")

    # Save the graph as a PNG file
    plt.savefig(output_file)
    print(f"Gráfico generado: {output_file}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Uso: generate_graph.py <archivo_log> <archivo_salida>")
        sys.exit(1)

    log_file = sys.argv[1]
    output_file = sys.argv[2]

    data = parse_log_file(log_file)
    generate_graph(data, output_file)