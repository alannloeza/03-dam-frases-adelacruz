# FrasesApp

Práctica **App Frases - Uso de BD** de Desarrollo de Aplicaciones Móviles.

Aplicación de Flutter para guardar, consultar, editar y eliminar frases en una
base de datos SQLite local. El formulario pide una frase de al menos cinco
caracteres y un autor. Las frases más recientes aparecen primero y se solicita
confirmación antes de eliminar una.

## Estructura

```text
lib/
  data/frases_db.dart
  models/frase.dart
  screens/formulario_screen.dart
  screens/home_screen.dart
  main.dart
```

- `Frase` representa una fila y convierte entre objetos y mapas.
- `FrasesDb` aplica Singleton y contiene las operaciones CRUD.
- Las pantallas muestran la lista y el formulario de creación y edición.
- La base se llama `misfrases.db` y su tabla es `frases`.

Los ejemplos de la guía se conservaron; se adaptaron las importaciones al
nombre del paquete `frases_app` y se agregó el punto de entrada en `main.dart`.

## Ejecutar en Android

```powershell
flutter pub get
flutter emulators --launch Pixel_10_Pro_XL
flutter devices
flutter run -d emulator-5554
```

En VS Code también se puede elegir **FrasesApp en Android** en Ejecutar y depurar.
Si el emulador utiliza otro identificador, selecciónalo en la barra de Flutter o
actualiza `deviceId` en `.vscode/launch.json`.

## Comprobaciones

```powershell
flutter analyze
flutter test
flutter test integration_test/frases_test.dart -d emulator-5554
```

La prueba de integración utiliza SQLite del emulador y comprueba validaciones,
creación, edición, cancelación de borrado y eliminación. Solo elimina el registro
temporal que la propia prueba crea.

## Evidencias de la práctica

Las respuestas de los recuadros azules deben escribirse **a mano**, al reverso del
mapa de doble burbuja. La guía también pide compartir una captura de la app en
el chat grupal de Teams y anotar el enlace del repositorio en el mapa.

[Guía del profesor](https://app.notion.com/p/App-Frases-Uso-de-BD-4147ddd65a8f8028ad3df8f5b57f0279)
