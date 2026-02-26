# GaleriaSwipeApp 📸

Proyecto desarrollado para el **1er Departamental** de la materia de Dispositivos Móviles en la carrera de **Ingeniería en Informática** del **Tecnológico de Estudios Superiores de Ecatepec (TESE)**.

Esta aplicación es una galería nativa desarrollada en **Flutter** que permite gestionar y visualizar las fotografías reales del dispositivo con una experiencia de usuario fluida y moderna.

## 🚀 Características (Features)

- **Acceso Nativo:** Gestión completa de permisos con `permission_handler` y consulta de media real con `photo_manager`.
- **Galería en Grid:** Visualización optimizada de miniaturas en una cuadrícula de 3 columnas.
- **Visor Premium:** Visualización a pantalla completa con indicador de posición (ej. 5/40).
- **Navegación por Gestos:** Implementación de `PageView.builder` para un swipe horizontal fluido entre imágenes.
- **Física de Mundo Real:** Efecto elástico (`BouncingScrollPhysics`) y animaciones de escala dinámica al desplazar.
- **Reto Implementado:** Soporte para **Pinch-to-Zoom** y **Pan** dinámico utilizando `InteractiveViewer`.

## 🛠️ Tecnologías Utilizadas

- **Lenguaje:** Dart
- **Framework:** Flutter
- **Dependencias Clave:**
  - `photo_manager`: Para el acceso eficiente a la galería del sistema.
  - `permission_handler`: Para el manejo de estados de permisos (concedido/denegado).
  - `InteractiveViewer`: Para la funcionalidad avanzada de zoom.

## 📋 Requisitos e Instalación

1. **Clonar el repositorio:**
   ```bash
   git clone [https://github.com/gaelking3231/galeria_swipe_app.git](https://github.com/gaelking3231/galeria_swipe_app.git)


   Instalar dependencias:
    Bash

    flutter pub get

    Ejecutar la aplicación:
    Asegúrate de tener un emulador o dispositivo físico conectado.
    Bash

    flutter run

    Nota: Es indispensable aceptar los permisos de acceso al almacenamiento al iniciar la app para que las fotos puedan cargarse correctamente.

👨‍💻 Autor

Gael King Estudiante de Ingeniería en Informática - TESE Founder @ GLIF Agency
