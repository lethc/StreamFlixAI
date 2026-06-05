# 🎬 StreamFlix IA

Sistema de recomendación de películas desarrollado con Java Web, JSP, Apache Tomcat y Weka.

El proyecto utiliza un árbol de decisión J48 para analizar las preferencias del usuario y generar recomendaciones personalizadas de películas según:

- Género
- Edad
- Frecuencia de visualización

Además muestra:

- Película recomendada
- Precisión del modelo
- Métricas de evaluación
- Árbol de decisión generado por Weka
- Recomendaciones relacionadas usando recursividad
- Interfaz web inspirada en plataformas de streaming

---

# 🛠 Tecnologías utilizadas

- Java 17+
- JSP (Java Server Pages)
- Apache Tomcat 9
- Weka 3.8
- HTML5
- CSS3
- Eclipse IDE

---

# 📦 Dependencias necesarias

## 1. Java JDK

Verificar instalación:

```bash
java --version
```

Se recomienda:

```text
Java 17 o superior
```

---

## 2. Apache Tomcat

Versión utilizada:

```text
Apache Tomcat 9.x
```

Configurar Tomcat dentro de Eclipse antes de ejecutar el proyecto.

---

## 3. Eclipse IDE

Se recomienda:

```text
Eclipse IDE for Enterprise Java and Web Developers
```

---

## 4. Weka

Descargar:

https://www.cs.waikato.ac.nz/ml/weka/

Agregar:

```text
weka.jar
```

en:

```text
src/main/webapp/WEB-INF/lib/
```

---

# 📁 Estructura principal

```text
StreamFlixIA
│
├── src
│   └── main
│       ├── java
│       │   └── util
│       │       └── Recursividad.java
│       │
│       └── webapp
│           ├── data
│           │   └── peliculas.arff
│           │
│           ├── img
│           │   └── *.jpg
│           │
│           ├── index.jsp
│           └── recomendar.jsp
│
└── WEB-INF
    └── lib
        └── weka.jar
```

---

# ▶️ Ejecución

1. Importar el proyecto en Eclipse.
2. Configurar Apache Tomcat.
3. Verificar que `weka.jar` se encuentre dentro de:

```text
WEB-INF/lib
```

4. Ejecutar:

```text
Run As → Run on Server
```

5. Abrir:

```text
http://localhost:9090/StreamFlixIA/
```

---

# 🧠 Dataset

El sistema utiliza un archivo ARFF:

```text
peliculas.arff
```

que contiene:

- Género
- Edad
- Frecuencia
- Película recomendada

El modelo se entrena automáticamente cada vez que se solicita una recomendación.

---

# 📚 Conceptos aplicados

- Inteligencia Artificial
- Machine Learning
- Árboles de decisión (J48)
- Clasificación supervisada
- Validación cruzada
- Recursividad
- Desarrollo Web con Java

---

# 👨‍💻 Autor

Proyecto académico desarrollado como sistema de recomendación de películas utilizando Weka y Java Web.
