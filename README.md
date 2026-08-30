# GameVault

## Descripción del proyecto

GameVault es una aplicación móvil desarrollada en Flutter que permite explorar videojuegos y guardar aquellos que resulten de interés dentro de una colección personal denominada "Mi Vault".

La aplicación obtiene información real de videojuegos mediante la API de RAWG, permitiendo visualizar datos como el nombre del juego, imagen, calificación, fecha de lanzamiento, géneros y plataformas disponibles.

Este proyecto fue desarrollado como parte de la Actividad Integradora 2 de la asignatura de Desarrollo de Aplicaciones Móviles.

## Actividad Integradora 2

Para la Actividad Integradora 2 se decidió desarrollar una nueva aplicación con temática de videojuegos denominada GameVault, en lugar de continuar modificando el proyecto MeCuadra presentado anteriormente.

MeCuadra es un proyecto que ya cuenta con una estructura y arquitectura más avanzada, donde se utilizan herramientas como Riverpod para el manejo de estado y GoRouter para la navegación entre pantallas. Debido a que esta actividad solicita trabajar específicamente con conceptos como `Navigator` y `setState()`, se consideró más adecuado desarrollar un nuevo proyecto que permitiera aplicar estos elementos directamente y comprender su funcionamiento sin modificar la arquitectura existente de MeCuadra.

De esta manera, GameVault fue desarrollado específicamente para aplicar los contenidos solicitados en la Actividad Integradora 2, incluyendo navegación mediante `Navigator`, manejo de estado con `setState()`, incorporación de nuevos widgets, interacción entre diferentes pantallas y utilización de un paquete externo de Flutter.

El proyecto MeCuadra se mantiene de forma independiente, conservando la estructura y las tecnologías utilizadas durante su desarrollo.

## Objetivo

El objetivo de GameVault es proporcionar una aplicación sencilla que permita consultar videojuegos disponibles mediante una fuente de información externa y organizar aquellos que sean de interés para el usuario.

Durante el desarrollo se aplicaron conceptos fundamentales de Flutter relacionados con:

- Organización de un proyecto mediante carpetas.
- Construcción de interfaces con widgets.
- Navegación entre pantallas.
- Manejo básico del estado mediante setState.
- Listas y cuadrículas dinámicas.
- Interacciones con el usuario.
- Consumo de información desde Internet.
- Uso de paquetes externos.
- Personalización visual de una aplicación Flutter.


## Pantallas de la aplicación

GameVault cuenta con cuatro pantallas principales.

### 1. Inicio

Es la pantalla principal de la aplicación. Presenta videojuegos destacados y populares obtenidos mediante la API de RAWG.

Desde esta pantalla es posible acceder al catálogo completo, consultar el detalle de un videojuego o ingresar a Mi Vault.

### 2. Explorar juegos

Presenta los videojuegos mediante una cuadrícula utilizando GridView.

Esta pantalla también incluye un buscador que permite filtrar los videojuegos por su nombre mientras el usuario escribe.

### 3. Detalle del juego

Muestra información adicional del videojuego seleccionado:

- Nombre.
- Imagen.
- Calificación.
- Fecha de lanzamiento.
- Géneros.
- Plataformas.

Desde esta pantalla el usuario también puede agregar o eliminar el videojuego de Mi Vault.

### 4. Mi Vault

Permite visualizar los videojuegos que el usuario ha marcado como favoritos durante la ejecución de la aplicación.

Desde esta pantalla es posible:

- Abrir nuevamente el detalle de un videojuego.
- Eliminar un juego individualmente.
- Vaciar completamente Mi Vault.
- Regresar a explorar videojuegos cuando la colección está vacía.

## Navegación

La navegación entre las diferentes pantallas se implementó utilizando Navigator y MaterialPageRoute.

Ejemplo:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => GameDetailScreen(game: game),
  ),
);
```

También se utiliza Navigator.pop para regresar entre pantallas y para controlar determinadas acciones dentro de los cuadros de diálogo.

## Widgets utilizados

Durante el desarrollo de GameVault se utilizaron diferentes widgets de Flutter, entre ellos:

- MaterialApp
- Scaffold
- AppBar
- ListView
- GridView
- ListTile
- Card
- Image
- Icon
- TextField
- ElevatedButton
- IconButton
- Padding
- SizedBox
- Expanded
- Container
- SingleChildScrollView
- AlertDialog
- SnackBar

Estos widgets permiten construir las diferentes pantallas y proporcionar interacción con el usuario.

## Interacciones implementadas

La aplicación incluye diferentes tipos de interacción.

### Navegación entre pantallas

El usuario puede desplazarse entre Inicio, Explorar juegos, Detalle del juego y Mi Vault.

### Búsqueda de videojuegos

En la pantalla Explorar juegos se incorporó un campo de búsqueda que filtra los videojuegos de acuerdo con el texto ingresado.

### Gestión de favoritos

Los videojuegos pueden agregarse o eliminarse de Mi Vault.

Cuando se realiza esta acción se muestra un SnackBar informando al usuario sobre el resultado.

### Eliminación de videojuegos

Desde Mi Vault se puede eliminar un videojuego individualmente.

También existe una opción para eliminar todos los videojuegos guardados. Antes de realizar esta acción se muestra un AlertDialog solicitando confirmación.

## Uso de setState

Se utilizó setState para actualizar información de la interfaz cuando cambia el estado de la aplicación.

Uno de sus usos se encuentra en la pantalla de detalle, donde permite cambiar el estado de un videojuego entre guardado y no guardado.

Ejemplo:

```dart
setState(() {
  _isFavorite = !_isFavorite;
});
```

También se utiliza para actualizar el buscador del catálogo y la información mostrada dentro de Mi Vault.

## Paquete externo utilizado

Se utilizó el paquete `http` para realizar solicitudes HTTP desde Flutter.

El paquete se encuentra declarado dentro de las dependencias del proyecto y se utiliza en `RawgService` para consultar información de videojuegos.

Ejemplo:

```dart
import 'package:http/http.dart' as http;

final response = await http.get(url);
```

La información recibida es procesada y convertida en objetos del modelo `Game` para posteriormente ser mostrada en las diferentes pantallas.

## API utilizada

GameVault utiliza la API de RAWG Video Games Database como fuente de información de videojuegos.

Los datos obtenidos incluyen:

- Nombre.
- Imagen.
- Calificación.
- Fecha de lanzamiento.
- Géneros.
- Plataformas.

Para utilizar la API es necesario disponer de una API Key.

Por seguridad, la clave no se deberia encontrar almacenada, pero debido que soy el dueño de la key y tengo el control para refrescarla la compartire dentro de del README y cuando esta actividad sea calificada dejara de ser reutilizable por motivos de seguridad, en la parte de ejecución dejo indicativos del uso.

La aplicación recibe la clave mediante `dart-define`:

```bash
flutter run --dart-define=RAWG_API_KEY=TU_API_KEY
```

```KEY TEMPORAL
f2029e04b7634398bcaa922fa8b1e6c8
```


Los datos e imágenes de videojuegos utilizados por GameVault son proporcionados por RAWG Video Games Database.

## Personalización

La aplicación fue personalizada específicamente para GameVault.

Se realizaron los siguientes cambios:

- Nombre de la aplicación: GameVault.
- Icono personalizado de la aplicación.
- Logo propio.
- Tema oscuro.
- Colores personalizados.
- Diseño de tarjetas para los videojuegos.
- Diseño específico para las pantallas de catálogo, detalle y favoritos.

Para la generación de los iconos correspondientes a Android e iOS se utilizó `flutter_launcher_icons`.

## Ejecución

Para instalar las dependencias del proyecto:

```bash
flutter pub get
```

Para verificar el proyecto:

```bash
flutter analyze
```

Para ejecutar GameVault proporcionando la clave de RAWG, escoger de acuerdo los emuladores instalados en la maquina a ejecutar, de mi parte comparto mis comandos de ejecución de los emuladores de mi sistema

## ANDROID
```bash
flutter run -d "emulator-5554" --dart-define=RAWG_API_KEY=f2029e04b7634398bcaa922fa8b1e6c8
```
## IOS
```bash
flutter run -d "iPhone 17" --dart-define=RAWG_API_KEY=f2029e04b7634398bcaa922fa8b1e6c8    
```
La aplicación fue probada correctamente en un emulador Android e IOS

## Control de versiones

El proyecto utiliza Git para el control de versiones y GitHub como repositorio remoto.

Durante el desarrollo se realizaron al menos 10 commits, registrando progresivamente la creación y evolución de las funcionalidades de GameVault.

## Tecnologías utilizadas

- Flutter
- Dart
- Material Design
- Navigator
- API REST
- RAWG Video Games Database
- Git
- GitHub
- Android Emulator

## Autor

Luis Fernando Bustamante

## Fuente de datos

La información e imágenes relacionadas con videojuegos son obtenidas mediante RAWG Video Games Database.

RAWG API:
https://rawg.io/apidocs