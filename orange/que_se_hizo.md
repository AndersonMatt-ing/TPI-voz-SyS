Solo para que se entienda que se hizo hasta ahora!!



Resumen de Pruebas y Resultados en Orange: Detección de Parkinson


Este documento resume las pruebas realizadas en Orange utilizando el archivo CSV con las características extraídas (Jitter, Shimmer, Energía) de la base de datos original PC-GITA de 100 muestras. El objetivo es explicar cómo estructuramos el análisis, qué métricas obtuvimos y por qué el rendimiento del modelo mejoró significativamente al cambiar la forma en que manejamos los datos faltantes.

1. El Pipeline en Orange: ¿Qué hace cada módulo?
Para que el sistema de Inteligencia Artificial funcione, conectamos una serie de nodos (widgets) en Orange que representan el flujo de los datos:

File: Carga nuestro archivo CSV y asigna los roles a las columnas. Define que sujeto_id es información extra (meta), grupo es lo que queremos predecir (target: 1 para Parkinson, 0 para Sano), y el resto son las variables a analizar (features).

Impute: Es el filtro para manejar los datos faltantes (NaN). En nuestro CSV, 20 pacientes tenían campos vacíos porque la señal acústica no permitió extraer los picos correctamente. Este nodo decide qué hacer con ellos.

SVM (Máquina de Vectores de Soporte): Es nuestro primer modelo matemático. Dibuja una frontera geométrica compleja (usando una función llamada Kernel RBF) para separar a los pacientes sanos de los enfermos en el espacio multidimensional.

Random Forest (Bosque Aleatorio): Es nuestro segundo modelo. Crea 100 "árboles de decisión" que hacen preguntas de Sí/No sobre los datos y luego votan para dar un diagnóstico final.

Test and Score: Es el juez. Toma los datos limpios, entrena a los modelos y los evalúa usando la técnica Leave-One-Out (entrena con 99 pacientes y prueba con 1, repitiendo el proceso para todos).

Confusion Matrix & ROC Analysis: Generan las tablas y gráficos visuales para entender en qué se equivocan los modelos y qué tan bien separan a los grupos.

2. Primera Prueba: El problema de "promediar" datos vacíos
En nuestro primer intento, configuramos el nodo Impute para que rellenara los datos de los 20 pacientes vacíos utilizando el "promedio" del resto de la población.

Reporte de resultados (Imputación por promedio):

Random Forest: AUC: 0.476 | CA: 0.495 | F1: 0.493 | Prec: 0.494 | Recall: 0.495 | MCC: -0.013

SVM: AUC: 0.502 | CA: 0.560 | F1: 0.548 | Prec: 0.561 | Recall: 0.560 | MCC: 0.117

¿Qué significa esto?
Los resultados fueron malos. Un AUC de 0.502 en el SVM significa que el modelo estaba tomando decisiones casi al azar, como tirar una moneda.
El error aquí fue conceptual: al rellenar los datos faltantes con promedios, creamos matemáticamente "pacientes sintéticos" que mezclaban características de voces sanas y enfermas. Le metimos ruido al modelo, lo que destruyó su capacidad para encontrar diferencias reales.

3. Segunda Prueba: La mejora al eliminar datos vacíos
Para solucionar el problema, cambiamos la configuración del nodo Impute a Remove rows with missing values. Es decir, decidimos sacrificar esos 20 audios problemáticos y trabajar únicamente con los 80 pacientes de la base original que tenían datos acústicos puros e intactos.

Reporte de resultados (Eliminando filas vacías):

Random Forest: AUC: 0.588 | CA: 0.575 | F1: 0.575 | Prec: 0.575 | Recall: 0.575 | MCC: 0.149

SVM: AUC: 0.685 | CA: 0.625 | F1: 0.624 | Prec: 0.625 | Recall: 0.625 | MCC: 0.249

¿Por qué mejoró el sistema?
Al darle a los clasificadores únicamente datos 100% reales, la "frontera" entre sanos y enfermos se volvió mucho más clara. El SVM logró dar un salto importantísimo, demostrando ser superior al Random Forest para este tipo de bioseñales continuas.

4. Guía rápida de métricas: ¿Cómo leer los reportes?
Para entender exactamente la mejora de la segunda prueba, esta es la traducción simple de cada sigla de la tabla:

AUC (Área Bajo la Curva): Es la métrica más importante. Mide la capacidad del modelo para separar las dos clases independientemente de las falsas alarmas. 0.50 es azar; 1.0 es perfección. Pasar de 0.502 a 0.685 con el SVM demuestra que las variables de Jitter y Shimmer sí contienen información clínica valiosa para diferenciar las voces.

CA (Exactitud / Classification Accuracy): Es el porcentaje total de aciertos. El SVM subió al 62.5%, es decir, acierta el diagnóstico en más de 6 de cada 10 pacientes.

F1, Prec (Precisión) y Recall (Sensibilidad): Evalúan el equilibrio entre detectar correctamente a los enfermos sin dar demasiadas falsas alarmas a los sanos. Subir al 0.625 indica un modelo mucho más equilibrado que no se inclina ciegamente hacia un solo diagnóstico.

MCC (Coeficiente de Matthews): Es la prueba de fuego de la estadística. 0 significa que no hay relación entre la predicción y la realidad. Pasar de un valor cercano a cero a 0.249 confirma matemáticamente que los aciertos del SVM no son por suerte, sino que hay una correlación real aprendida de los datos acústicos.

Conclusión para el equipo
La limpieza estricta de la base de datos es vital. El procesamiento mediante wavelets Daubechies-4 funciona y el modelo SVM es nuestra mejor herramienta de clasificación. Aunque comprimir las ventanas temporales en un solo promedio por paciente limita el potencial máximo del algoritmo, hemos logrado comprobar empíricamente que la inestabilidad glótica del Parkinson puede ser detectada y clasificada por nuestro sistema.