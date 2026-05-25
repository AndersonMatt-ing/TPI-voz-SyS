# TPI — Análisis de Señales de Voz con Transformada de Fourier

Trabajo Práctico Integrador de la materia Señales y Sistemas (o afín).  
Análisis de señales de voz usando la Transformada de Fourier (DFT / FFT) con Python.

---

## Objetivo

Explorar, preprocesar y representar señales de audio en el dominio de la frecuencia mediante la Transformada de Fourier, y extraer conclusiones sobre sus características espectrales.

---

## Estructura del proyecto

```
tpi-voz-tf/
├── README.md
├── .gitignore
├── requirements.txt
├── data/                  # Audios de entrada (no incluidos en el repo)
├── notebooks/
│   ├── 01_exploracion.ipynb           # Carga y visualización inicial
│   ├── 02_preprocesamiento.ipynb      # Filtrado, normalización, segmentación
│   ├── 03_representaciones_tf.ipynb   # DFT, FFT, espectrograma
│   └── 04_resultados.ipynb            # Análisis comparativo y conclusiones
├── figuras/               # Gráficos exportados para el informe
└── informe/               # Documento final
```

---

## Requisitos

- Python 3.9+
- Ver `requirements.txt`

## Instalación

```bash
git clone https://github.com/TU_USUARIO/tpi-voz-tf.git
cd tpi-voz-tf
pip install -r requirements.txt
```

## Cómo correr los notebooks

1. Colocar los archivos de audio `.wav` dentro de la carpeta `data/`
2. Abrir Jupyter Lab o Jupyter Notebook:
   ```bash
   jupyter lab
   ```
3. Ejecutar los notebooks en orden: `01` → `02` → `03` → `04`

---

## Datos

Los audios **no están incluidos** en el repositorio (están en `.gitignore`).  
Pueden obtenerse de:
- Grabaciones propias en formato `.wav`
- Datasets públicos como [LibriSpeech](https://www.openslr.org/12) o [VoxForge](http://www.voxforge.org/)

---

## Autores

- Mateo Anderson
