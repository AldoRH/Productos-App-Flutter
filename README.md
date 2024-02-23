# Productos-App
## Descripción
Esta aplicación te permite gestionar y visualizar productos utilizando Firebase como backend. Puedes autenticarte, agregar y editar productos, y todas las actualizaciones se reflejarán en tiempo real gracias a Firebase Realtime Database.

## Requisitos previos
Antes de ejecutar la aplicación, asegúrate de tener Flutter instalado en tu sistema. Puedes encontrar instrucciones para instalar Flutter [aquí](https://flutter.dev/).


## Configuración de Firebase y Cloudinary
Esta aplicación utiliza Firebase para la autenticación y almacenamiento de datos en tiempo real, y Cloudinary para gestionar las imágenes de los productos.

Firebase
Crea un proyecto en [Firebase](https://firebase.google.com/).
Configura la autenticación y la base de datos en tiempo real en la consola de Firebase.
Obten la Clave de API web de tu proyecto Firebase.

Cloudinary
Crea una cuenta en [Cloudinary](https://cloudinary.com/).
Configura tu cuenta y obtén el nombre de tu nube (CLOUD_NAME) y obten la liga para poder subir imagenes al Media Library.

## Configuración de .env
Crea un archivo .env en el directorio raíz de tu proyecto y agrega las siguientes líneas:

FIRE_BASE=URL_DE_TU_BASE_DE_DATOS_FIREBASE

FIRE_BASE_TOKEN=TU_CLAVE_DE_API_WEB_FIREBASE

CLOUD_NAME=LIGA_PARA_PODER_SUBIR_IMAGENES

Reemplaza URL_DE_TU_BASE_DE_DATOS_FIREBASE, TU_CLAVE_DE_API_WEB_FIREBASE y TU_NOMBRE_DE_NUBE_CLOUDINARY con la información correspondiente.


## Instalación de flutter_dotenv
Este proyecto utiliza flutter_dotenv para cargar variables de entorno desde el archivo .env.

Asegúrate de importar y cargar el archivo .env en tu aplicación. Puedes hacerlo en el punto de entrada de tu aplicación (por ejemplo, main.dart):
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load();
  runApp(MyApp());
}

## Ejecutando la aplicación
Después de completar la configuración anterior, puedes ejecutar la aplicación con:
flutter run






